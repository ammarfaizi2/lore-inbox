Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261861AbVDKRd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbVDKRd4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 13:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbVDKRd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 13:33:56 -0400
Received: from bernache.ens-lyon.fr ([140.77.167.10]:36585 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261861AbVDKRdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 13:33:52 -0400
Date: Mon, 11 Apr 2005 19:33:40 +0200
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, sfrench@samba.org,
       Jan Dittmer <jdittmer@ppp0.net>
Subject: Re: 2.6.12-rc2-mm3
Message-ID: <20050411173340.GA16873@ens-lyon.fr>
References: <20050411012532.58593bc1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050411012532.58593bc1.akpm@osdl.org>
User-Agent: Mutt/1.5.8i
X-Spam-Report: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2005 at 01:25:32AM -0700, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm3/
> 
> 
> Changes since 2.6.12-rc2-mm2:
> 
> 
>  bk-cifs.patch


The following patch correct an error in bk-cifs:

fs/cifs/misc.c: In function ‘cifs_convertUCSpath’:
fs/cifs/misc.c:546: error: case label does not reduce to an integer constant
fs/cifs/misc.c:549: error: case label does not reduce to an integer constant
fs/cifs/misc.c:552: error: case label does not reduce to an integer constant
fs/cifs/misc.c:561: error: case label does not reduce to an integer constant
fs/cifs/misc.c:564: error: case label does not reduce to an integer constant
fs/cifs/misc.c:567: error: case label does not reduce to an integer constant

The utilisations of UNI_* constants show that it is should in cpu format:

for example line 542, src_char is converted in cpu_format:
               src_char = le16_to_cpu(source[i]);
	                       switch (src_char) {
			        ...
					case UNI_COLON:
				...

or line 610, it is unlikely that you want to have cpu_to_le16(cpu_to_le16(x)):
		target[j] = cpu_to_le16(UNI_COLON);

the following patch fixes it.

Signed-Off-By: Benoit Boissinot <benoit.boissinot@ens-lyon.org>


--- ./fs/cifs/misc.c.orig	2005-04-11 19:18:11.000000000 +0200
+++ ./fs/cifs/misc.c	2005-04-11 19:18:30.000000000 +0200
@@ -519,13 +519,13 @@ dump_smb(struct smb_hdr *smb_buf, int sm
 /* Windows maps these to the user defined 16 bit Unicode range since they are
    reserved symbols (along with \ and /), otherwise illegal to store
    in filenames in NTFS */
-#define UNI_ASTERIK     cpu_to_le16('*' + 0xF000)
-#define UNI_QUESTION    cpu_to_le16('?' + 0xF000)
-#define UNI_COLON       cpu_to_le16(':' + 0xF000)
-#define UNI_GRTRTHAN    cpu_to_le16('>' + 0xF000)
-#define UNI_LESSTHAN    cpu_to_le16('<' + 0xF000)
-#define UNI_PIPE        cpu_to_le16('|' + 0xF000)
-#define UNI_SLASH       cpu_to_le16('\\' + 0xF000)
+#define UNI_ASTERIK     ('*' + 0xF000)
+#define UNI_QUESTION    ('?' + 0xF000)
+#define UNI_COLON       (':' + 0xF000)
+#define UNI_GRTRTHAN    ('>' + 0xF000)
+#define UNI_LESSTHAN    ('<' + 0xF000)
+#define UNI_PIPE        ('|' + 0xF000)
+#define UNI_SLASH       ('\\' + 0xF000)
 
 /* Convert 16 bit Unicode pathname from wire format to string in current code
    page.  Conversion may involve remapping up the seven characters that are
