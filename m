Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283403AbRLDOog>; Tue, 4 Dec 2001 09:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283166AbRLDOmj>; Tue, 4 Dec 2001 09:42:39 -0500
Received: from mail.lightning.ch ([193.247.134.3]:32275 "HELO
	mail.lightning.ch") by vger.kernel.org with SMTP id <S284355AbRLDOVw>;
	Tue, 4 Dec 2001 09:21:52 -0500
Message-ID: <3C0CB59B.EEA251AB@lightning.ch>
Date: Tue, 04 Dec 2001 12:38:03 +0100
From: Daniel Marmier <daniel.marmier@lightning.ch>
Reply-To: daniel.marmier@lightning.ch
Organization: LIGHTNING Instrumentation SA
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.17 i686)
X-Accept-Language: chose, fr, en
MIME-Version: 1.0
To: Jeremy Puhlman <jpuhlman@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Endianness-aware mkcramfs
In-Reply-To: <3C0BD8FD.F9F94BE0@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Puhlman wrote:
> 
> Hello Daniel,

Hi Jeremy,

>     Are you maintaining this patch? If so could you point me to a more
> current version?

Here you are, against kernel 2.4.16. The patch is not as clean as one
would like it to be, but we use it and it works well for us.

Basically it adds a "-b" (byteorder option) which can take four parameters:
   -bb	creates a big-endian cramfs,
   -bl	creates a little-endian cramfs,
   -bh	creates a cramfs with the same endianness as the host,
   -br	creates a cramfs with the reverse endianness as the host,
where "host" refers to the machine running the mkcramfs program.

As told above, it could be cleaner, but I don't know of a nice method of
accessing byteorder dependent data through structures.

Have a nice day,


				Daniel Marmier


Index: mkcramfs.c
===================================================================
RCS file: /export/cvsroot/soft/kernel/scripts/cramfs/mkcramfs.c,v
retrieving revision 1.1.1.6
retrieving revision 1.4
diff -u -r1.1.1.6 -r1.4
--- mkcramfs.c	2001/10/02 13:49:48	1.1.1.6
+++ mkcramfs.c	2001/10/10 11:24:33	1.4
@@ -44,8 +44,9 @@
 {
 	FILE *stream = status ? stderr : stdout;
 
-	fprintf(stream, "usage: %s [-h] [-e edition] [-i file] [-n name] dirname outfile\n"
+	fprintf(stream, "usage: %s [-h] [-b byteorder] [-e edition] [-i file] [-n name] dirname outfile\n"
 		" -h         print this help\n"
+		" -b {blhr}  select byte order (big/little/host/reverse)\n"
 		" -E         make all warnings errors (non-zero exit status)\n"
 		" -e edition set edition number (part of fsid)\n"
 		" -i file    insert a file image into the filesystem (requires >= 2.4.0)\n"
@@ -80,6 +81,7 @@
 static char *opt_image = NULL;
 static char *opt_name = NULL;
 
+static int reverse_endian;
 static int warn_dev, warn_gid, warn_namelen, warn_skip, warn_size, warn_uid;
 
 #ifndef MIN
@@ -113,6 +115,17 @@
  */
 #define MAX_INPUT_NAMELEN 255
 
+static unsigned long htocl(unsigned long x)
+{
+	if (reverse_endian)
+		return ((x << 24) & 0xff000000) |
+		       ((x <<  8) & 0x00ff0000) |
+		       ((x >>  8) & 0x0000ff00) |
+		       ((x >> 24) & 0x000000ff);
+	else
+		return x;
+}
+
 static int find_identical_file(struct entry *orig,struct entry *newfile)
 {
         if(orig==newfile) return 1;
@@ -307,29 +320,56 @@
 	return totalsize;
 }
 
+static unsigned int write_entry(struct entry *entry, char *base)
+{
+	unsigned long *p = (unsigned long *)base;
+
+	p[0] = htocl((entry->mode << 16) | (entry->uid & 0xffff));
+	p[1] = htocl((entry->size << 8) | (entry->gid & 0xff));
+	p[2] = htocl(0);
+	return sizeof(struct entry);
+}
+
+static void set_data_offset(struct entry *entry, char *base, unsigned long offset)
+{
+	struct cramfs_inode *inode = (struct cramfs_inode *) (base + entry->dir_offset);
+	unsigned long *p = ((unsigned long *)inode) + 2;
+	unsigned long namelen;
+#ifdef DEBUG
+	assert ((offset & 3) == 0);
+#endif /* DEBUG */
+	if (offset >= (1 << (2 + CRAMFS_OFFSET_WIDTH))) {
+		fprintf(stderr, "filesystem too big.  Exiting.\n");
+		exit(8);
+	}
+	*p |= htocl(offset >> 2);
+}
+
 /* Returns sizeof(struct cramfs_super), which includes the root inode. */
 static unsigned int write_superblock(struct entry *root, char *base, int size)
 {
 	struct cramfs_super *super = (struct cramfs_super *) base;
 	unsigned int offset = sizeof(struct cramfs_super) + image_length;
+	unsigned int flags;
 
 	if (opt_pad) {
 		offset += opt_pad;
 	}
 
-	super->magic = CRAMFS_MAGIC;
-	super->flags = CRAMFS_FLAG_FSID_VERSION_2 | CRAMFS_FLAG_SORTED_DIRS;
+	super->magic = htocl(CRAMFS_MAGIC);
+	flags = CRAMFS_FLAG_FSID_VERSION_2 | CRAMFS_FLAG_SORTED_DIRS;
 	if (opt_holes)
-		super->flags |= CRAMFS_FLAG_HOLES;
+		flags |= CRAMFS_FLAG_HOLES;
 	if (image_length > 0)
-		super->flags |= CRAMFS_FLAG_SHIFTED_ROOT_OFFSET;
-	super->size = size;
+		flags |= CRAMFS_FLAG_SHIFTED_ROOT_OFFSET;
+	super->flags = htocl(flags);
+	super->size = htocl(size);
 	memcpy(super->signature, CRAMFS_SIGNATURE, sizeof(super->signature));
 
-	super->fsid.crc = crc32(0L, Z_NULL, 0);
-	super->fsid.edition = opt_edition;
-	super->fsid.blocks = total_blocks;
-	super->fsid.files = total_nodes;
+	super->fsid.crc = htocl(crc32(0L, Z_NULL, 0));
+	super->fsid.edition = htocl(opt_edition);
+	super->fsid.blocks = htocl(total_blocks);
+	super->fsid.files = htocl(total_nodes);
 
 	memset(super->name, 0x00, sizeof(super->name));
 	if (opt_name)
@@ -337,29 +377,12 @@
 	else
 		strncpy(super->name, "Compressed", sizeof(super->name));
 
-	super->root.mode = root->mode;
-	super->root.uid = root->uid;
-	super->root.gid = root->gid;
-	super->root.size = root->size;
-	super->root.offset = offset >> 2;
+	write_entry(root, (char *)&super->root);
+	set_data_offset(root, (char *)&super->root, offset);
 
 	return offset;
 }
 
-static void set_data_offset(struct entry *entry, char *base, unsigned long offset)
-{
-	struct cramfs_inode *inode = (struct cramfs_inode *) (base + entry->dir_offset);
-#ifdef DEBUG
-	assert ((offset & 3) == 0);
-#endif /* DEBUG */
-	if (offset >= (1 << (2 + CRAMFS_OFFSET_WIDTH))) {
-		fprintf(stderr, "filesystem too big.  Exiting.\n");
-		exit(8);
-	}
-	inode->offset = (offset >> 2);
-}
-
-
 /*
  * We do a width-first printout of the directory
  * entries, using a stack to remember the directories
@@ -376,14 +399,11 @@
 		while (entry) {
 			struct cramfs_inode *inode = (struct cramfs_inode *) (base + offset);
 			size_t len = strlen(entry->name);
+			unsigned long *p = ((unsigned long *)inode) + 2;
 
 			entry->dir_offset = offset;
 
-			inode->mode = entry->mode;
-			inode->uid = entry->uid;
-			inode->gid = entry->gid;
-			inode->size = entry->size;
-			inode->offset = 0;
+			write_entry(entry, (char *)inode);
 			/* Non-empty directories, regfiles and symlinks will
 			   write over inode->offset later. */
 
@@ -395,7 +415,7 @@
 				*(base + offset + len) = '\0';
 				len++;
 			}
-			inode->namelen = len >> 2;
+			*p = htocl((len >> 2) << CRAMFS_OFFSET_WIDTH);
 			offset += len;
 
 			/* TODO: this may get it wrong for chars >= 0x80.
@@ -503,7 +523,7 @@
 			exit(8);
 		}
 
-		*(u32 *) (base + offset) = curr;
+		*(u32 *) (base + offset) = htocl(curr);
 		offset += 4;
 	} while (size);
 
@@ -590,6 +610,9 @@
  */
 int main(int argc, char **argv)
 {
+	char endian = 'h';
+	int big_endian;
+	unsigned char test_endian[] = { 0x12, 0x34 };
 	struct stat st;		/* used twice... */
 	struct entry *root_entry;
 	char *rom_image;
@@ -607,10 +630,13 @@
 		progname = argv[0];
 
 	/* command line options */
-	while ((c = getopt(argc, argv, "hEe:i:n:psz")) != EOF) {
+	while ((c = getopt(argc, argv, "hb:Ee:i:n:psz")) != EOF) {
 		switch (c) {
 		case 'h':
 			usage(0);
+		case 'b':
+			endian = *optarg;
+			break;
 		case 'E':
 			opt_errors = 1;
 			break;
@@ -642,6 +668,30 @@
 		}
 	}
 
+	/* find out host endianness */
+	big_endian = *(unsigned short *)test_endian == 0x1234;
+	/* find out (from host endianness and user's wish) if we need to swap words */
+	switch(endian) {
+	case 'b':
+		/* big endian image */
+		reverse_endian = !big_endian;
+		break;
+	case 'h':
+		/* host-like image (default) */
+		reverse_endian = 0;
+		break;
+	case 'l':
+		/* little endian image */
+		reverse_endian = big_endian;
+		break;
+	case 'r':
+		/* reverse-host image (big on little and vice versa) */
+		reverse_endian = 1;
+		break;
+	default:
+		usage(16);
+	}
+
 	if ((argc - optind) != 2)
 		usage(16);
 	dirname = argv[optind];
@@ -725,7 +775,7 @@
 
 	/* Put the checksum in. */
 	crc = crc32(crc, (rom_image+opt_pad), (offset-opt_pad));
-	((struct cramfs_super *) (rom_image+opt_pad))->fsid.crc = crc;
+	((struct cramfs_super *) (rom_image+opt_pad))->fsid.crc = htocl(crc);
 	printf("CRC: %x\n", crc);
 
 	/* Check to make sure we allocated enough space. */
