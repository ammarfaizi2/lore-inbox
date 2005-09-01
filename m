Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030317AbVIATRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030317AbVIATRE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 15:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030318AbVIATRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 15:17:04 -0400
Received: from main.gmane.org ([80.91.229.2]:10966 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030317AbVIATRC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 15:17:02 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ed L Cashin <ecashin@coraid.com>
Subject: Re: aoe fails on sparc64
Date: Thu, 01 Sep 2005 15:13:52 -0400
Message-ID: <87k6i0bnyn.fsf@coraid.com>
References: <3afbacad0508310630797f397d@mail.gmail.com>
	<87vf1mm7fk.fsf@coraid.com>
	<20050831.232430.50551657.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
Cc: "David S. Miller" <davem@davemloft.net>,
       Jim MacBaine <jmacbaine@gmail.com>
X-Gmane-NNTP-Posting-Host: adsl-19-26-204.asm.bellsouth.net
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
Cancel-Lock: sha1:irS6qUZA7jvPaY/8qOtYauikOsA=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@davemloft.net> writes:

> From: Ed L Cashin <ecashin@coraid.com>
...
>> OK.  67553994410557440 is 61440 byte swapped in 64 bits, and 30MB is
>> 61440 sectors, so this should be a simple byte order fix.
>
> More strangely, the upper and lower 32-bit words are swapped.
> The bytes within each 32-bit word are swapped correctly.
>
> So the calculation maybe should be something like:
>
> 	__le32 *p = (__le32 *) &id[100 << 1];
> 	u32 high32 = le32_to_cpup(p);
> 	u32 low32 = le32_to_cpup(p + 1);
>
> 	ssize = (((u64)high32 << 32) | (u64) low32);
>
> But that doesn't make any sense, and even ide_fix_driveid() in
> drivers/ide/ide-iops.c does a le64_to_cpu() for this value:
>
> 	id->lba_capacity_2 = __le64_to_cpu(id->lba_capacity_2);
>
> I wonder if this is some artifact of how AOE devices encode
> this field when sending it to the client.

Well, an EtherDrive blade just copies the ATA identify response data
into a network packet without looking at it.  The vblade, though, has
to set the lba_capacity and lba_capacity_2 fields itself.

The aoe driver looks OK, but it turns out there's a byte swapping bug
in the vblade that could be related if he's running the vblade on a
big endian host (even though he said it was an x86 host), but I
haven't heard back from the original poster yet.

The vblade bug was the omission of swapping the bytes in each short.
The fix below shows what I mean:

diff -urNp a-exp/ata.c b-exp/ata.c
--- a-exp/ata.c	2005-09-01 10:19:11.000000000 -0400
+++ b-exp/ata.c	2005-09-01 10:19:12.000000000 -0400
@@ -55,24 +55,29 @@ setfld(ushort *a, int idx, int len, char
 }
 
 static void
-setlba28(ushort *p, vlong lba)
+setlba28(ushort *ident, vlong lba)
 {
-	p += 60;
-	*p++ = lba & 0xffff;
-	*p = lba >> 16 & 0x0fffffff;
+	uchar *cp;
+
+	cp = (uchar *) &ident[60];
+	*cp++ = lba;
+	*cp++ = lba >>= 8;
+	*cp++ = lba >>= 8;
+	*cp++ = (lba >>= 8) & 0xf;
 }
 
 static void
-setlba48(ushort *p, vlong lba)
+setlba48(ushort *ident, vlong lba)
 {
-	p += 100;
-	*p++ = lba;
-	lba >>= 16;
-	*p++ = lba;
-	lba >>= 16;
-	*p++ = lba;
-	lba >>= 16;
-	*p = lba;
+	uchar *cp;
+
+	cp = (uchar *) &ident[100];
+	*cp++ = lba;
+	*cp++ = lba >>= 8;
+	*cp++ = lba >>= 8;
+	*cp++ = lba >>= 8;
+	*cp++ = lba >>= 8;
+	*cp++ = lba >>= 8;
 }
 		
 void


-- 
  Ed L Cashin <ecashin@coraid.com>

