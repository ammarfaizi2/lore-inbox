Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315442AbSEGNhw>; Tue, 7 May 2002 09:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315443AbSEGNhv>; Tue, 7 May 2002 09:37:51 -0400
Received: from [195.63.194.11] ([195.63.194.11]:42762 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315442AbSEGNht>; Tue, 7 May 2002 09:37:49 -0400
Message-ID: <3CD7C9F1.2000407@evision-ventures.com>
Date: Tue, 07 May 2002 14:34:57 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cantab.net>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 57
In-Reply-To: <Pine.LNX.4.44.0205052046590.1405-100000@home.transmeta.com> <5.1.0.14.2.20020507140736.022aed90@pop.cus.cam.ac.uk>
Content-Type: multipart/mixed;
 boundary="------------040004010208040203060508"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040004010208040203060508
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Uz.ytkownik Anton Altaparmakov napisa?:
> At 12:27 07/05/02, Martin Dalecki wrote:
> 
>> Tue May  7 02:37:49 CEST 2002 ide-clean-57
>>
>> Nuke /proc/ide. For explanations why, please see the frustrated 
>> comments in the previous change log.
> 
> 
> This is a big mistake IMO.
> 
> Nuking the ability to change settings, fair enough, but only if 
> alternative interface is provided for userspace to tweak everything, 
> otherwise provide the interface before you remove the existing one. 
> (There may be already another interface, I don't know...I am sure 
> someone will tell me if there is!)

Ehmm... There *is* one interface there. hdparm will help
you. Note: the upcomming release of hdparm should contain the
following patch which incearses it's usability vastly to the
average user. Just for convenience I'm attaching it here.

If you don't like hdparm - well please shoot the
people who wrote init, ifconfig, eject and so on...

--------------040004010208040203060508
Content-Type: text/plain;
 name="hdparm-4.9.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hdparm-4.9.diff"

diff -ur hdparm-4.9/hdparm.8 hdparm-4.9-new/hdparm.8
--- hdparm-4.9/hdparm.8	2002-04-29 16:27:55.000000000 +0200
+++ hdparm-4.9-new/hdparm.8	2002-05-02 14:54:56.000000000 +0200
@@ -368,14 +368,16 @@
 Tristate device for hotswap (DANGEROUS).
 .TP
 .I -X 
-Set the IDE transfer mode for newer (E)IDE/ATA2 drives.
+Set the IDE transfer mode for newer (E)IDE/ATA-7 drives.
 This is typically used in combination with
 .I -d1
 when enabling DMA to/from a drive on a supported interface chipset, where
-.I -X34
-is used to select multiword DMA mode2 transfers.
+.I -X mdma2
+is used to select multiword DMA mode2 transfers and
+.I -X sdma1 
+is used to select simple mode 1 DMA transfers.
 With systems which support UltraDMA burst timings,
-.I -X66
+.I -X udma2
 is used to select UltraDMA mode2 transfers (you'll need to prepare
 the chipset for UltraDMA beforehand).
 Apart from that, use of this flag is
diff -ur hdparm-4.9/hdparm.c hdparm-4.9-new/hdparm.c
--- hdparm-4.9/hdparm.c	2002-04-29 16:27:42.000000000 +0200
+++ hdparm-4.9-new/hdparm.c	2002-05-02 14:48:56.000000000 +0200
@@ -606,6 +606,66 @@
 	printf(")\n");
 }
 
+struct xfermode_entry {
+    int val;
+    char *name;
+};
+
+static struct xfermode_entry xfermode_table[] = {
+    { 8,    "pio0" },
+    { 9,    "pio1" },
+    { 10,   "pio2" },
+    { 11,   "pio3" },
+    { 12,   "pio4" },
+    { 13,   "pio5" },
+    { 14,   "pio6" },
+    { 15,   "pio7" },
+    { 16,   "sdma0" },
+    { 17,   "sdma1" },
+    { 18,   "sdma2" },
+    { 19,   "sdma3" },
+    { 20,   "sdma4" },
+    { 21,   "sdma5" },
+    { 22,   "sdma6" },
+    { 23,   "sdma7" },
+    { 32,   "mdma0" },
+    { 33,   "mdma1" },
+    { 34,   "mdma2" },
+    { 35,   "mdma3" },
+    { 36,   "mdma4" },
+    { 37,   "mdma5" },
+    { 38,   "mdma6" },
+    { 39,   "mdma7" },
+    { 64,   "udma0" },
+    { 65,   "udma1" },
+    { 66,   "udma2" },
+    { 67,   "udma3" },
+    { 68,   "udma4" },
+    { 69,   "udma5" },
+    { 70,   "udma6" },
+    { 71,   "udma7" },
+    { 0, NULL }
+};
+
+static unsigned int translate_xfermode(char * name)
+{
+    struct xfermode_entry *tmp;
+    char *endptr;
+    int val = -1;
+
+
+    for (tmp = xfermode_table; tmp->name; ++tmp) {
+	if (!strcmp(name, tmp->name))
+	    return tmp->val;
+    }
+
+    val = strtol(name, &endptr, 10);
+    if (*endptr == '\0')
+	return val;
+
+    return -1;
+}
+
 static void interpret_xfermode (unsigned int xfermode)
 {
 	printf(" (");
@@ -1408,9 +1468,26 @@
 					num = (num * 10) + (*p++ - '0'); \
 				}
 
+#define GET_STRING(flag, num) tmpstr = name; \
+				tmpstr[0] = '\0'; \
+				if (!*p && argc && isalnum(**argv)) \
+					p = *argv++, --argc; \
+				while (isalnum(*p) && (tmpstr - name < 31)) { \
+					tmpstr[0] = *p++; \
+					tmpstr[1] = '\0'; \
+					++tmpstr; \
+				} \
+				num = translate_xfermode(name); \
+				if (num == -1) \
+					flag = 0; \
+				else \
+					flag = 1;
+
 int main(int argc, char **argv)
 {
 	char c, *p;
+	char *tmpstr;
+	char name[32];
 
 	if  ((progname = (char *) strrchr(*argv, '/')) == NULL)
 		progname = *argv;
@@ -1491,7 +1568,7 @@
 					case 'p':
 						noisy_piomode = noisy;
 						noisy = 1;
-						GET_NUMBER(set_piomode,piomode);
+						GET_STRING(set_piomode,piomode);
 						break;
 #endif
 					case 'r':
@@ -1551,7 +1628,7 @@
 					case 'X':
 						get_xfermode = noisy;
 						noisy = 1;
-						GET_NUMBER(set_xfermode,xfermode);
+						GET_STRING(set_xfermode,xfermode);
 						if (!set_xfermode)
 							fprintf(stderr, "-X: missing value\n");
 						break;

--------------040004010208040203060508--

