Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965192AbWFZBxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965192AbWFZBxa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 21:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965140AbWFZBxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 21:53:30 -0400
Received: from mx1.suse.de ([195.135.220.2]:6118 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965118AbWFZBx3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 21:53:29 -0400
From: Neil Brown <neilb@suse.de>
To: Ronald Lembcke <es186@fen-net.de>
Date: Mon, 26 Jun 2006 11:53:06 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17567.15874.836519.525015@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: Bug in 2.6.17 / mdadm 2.5.1
In-Reply-To: message from Neil Brown on Monday June 26
References: <20060624104745.GA6352@defiant.crash>
	<20060625135926.GA6253@defiant.crash>
	<17567.13099.133933.397389@cse.unsw.edu.au>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday June 26, neilb@suse.de wrote:
> On Sunday June 25, es186@fen-net.de wrote:
> > Hi!
> > 
> > There's a bug in Kernel 2.6.17 and / or mdadm which prevents (re)adding
> > a disk to a degraded RAID5-Array.
> 
> Thank you for the detailed report.
> The bug is in the md driver in the kernel (not in mdadm), and only
> affects version-1 superblocks.  Debian recently changed the default
> (in /etc/mdadm.conf) to use version-1 superblocks which I thought
> would be OK (I've some testing) but obviously I missed something. :-(
> 
> If you remove the "metadata=1" (or whatever it is) from
> /etc/mdadm/mdadm.conf and then create the array, it will be created
> with a version-0.90 superblock has had more testing.
> 
> Alternately you can apply the following patch to the kernel and
> version-1 superblocks should work better.

And as a third alternate, you can apply this patch to mdadm-2.5.1
It will work-around the kernel bug.

NeilBrown

diff .prev/Manage.c ./Manage.c
--- .prev/Manage.c	2006-06-20 10:01:17.000000000 +1000
+++ ./Manage.c	2006-06-26 11:46:56.000000000 +1000
@@ -271,8 +271,14 @@ int Manage_subdevs(char *devname, int fd
 				 * If so, we can simply re-add it.
 				 */
 				st->ss->uuid_from_super(duuid, dsuper);
-			
-				if (osuper) {
+
+				/* re-add doesn't work for version-1 superblocks
+				 * before 2.6.18 :-(
+				 */
+				if (array.major_version == 1 &&
+				    get_linux_version() <= 2006018)
+					;
+				else if (osuper) {
 					st->ss->uuid_from_super(ouuid, osuper);
 					if (memcmp(duuid, ouuid, sizeof(ouuid))==0) {
 						/* look close enough for now.  Kernel
@@ -295,7 +301,10 @@ int Manage_subdevs(char *devname, int fd
 					}
 				}
 			}
-			for (j=0; j< st->max_devs; j++) {
+			/* due to a bug in 2.6.17 and earlier, we start
+			 * looking from raid_disks, not 0
+			 */
+			for (j = array.raid_disks ; j< st->max_devs; j++) {
 				disc.number = j;
 				if (ioctl(fd, GET_DISK_INFO, &disc))
 					break;

diff .prev/super1.c ./super1.c
--- .prev/super1.c	2006-06-20 10:01:46.000000000 +1000
+++ ./super1.c	2006-06-26 11:47:12.000000000 +1000
@@ -277,6 +277,18 @@ static void examine_super1(void *sbv, ch
 	default: break;
 	}
 	printf("\n");
+	printf("    Array Slot : %d (", __le32_to_cpu(sb->dev_number));
+	for (i= __le32_to_cpu(sb->max_dev); i> 0 ; i--)
+		if (__le16_to_cpu(sb->dev_roles[i-1]) != 0xffff)
+			break;
+	for (d=0; d < i; d++) {
+		int role = __le16_to_cpu(sb->dev_roles[d]);
+		if (d) printf(", ");
+		if (role == 0xffff) printf("empty");
+		else if(role == 0xfffe) printf("failed");
+		else printf("%d", role);
+	}
+	printf(")\n");
 	printf("   Array State : ");
 	for (d=0; d<__le32_to_cpu(sb->raid_disks); d++) {
 		int cnt = 0;
@@ -767,7 +779,8 @@ static int write_init_super1(struct supe
 		if (memcmp(sb->set_uuid, refsb->set_uuid, 16)==0) {
 			/* same array, so preserve events and dev_number */
 			sb->events = refsb->events;
-			sb->dev_number = refsb->dev_number;
+			if (get_linux_version() >= 2006018)
+				sb->dev_number = refsb->dev_number;
 		}
 		free(refsb);
 	}
