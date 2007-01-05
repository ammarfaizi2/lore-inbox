Return-Path: <linux-kernel-owner+w=401wt.eu-S1161147AbXAEQjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161147AbXAEQjE (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 11:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161146AbXAEQjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 11:39:04 -0500
Received: from moutng.kundenserver.de ([212.227.126.174]:61456 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161147AbXAEQjC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 11:39:02 -0500
X-Greylist: delayed 334 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Jan 2007 11:39:02 EST
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: [UPDATED PATCH] fix memory corruption from misinterpreted bad_inode_ops  return values
To: Eric Sandeen <sandeen@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@zeniv.linux.org.uk>
Reply-To: 7eggert@gmx.de
Date: Fri, 05 Jan 2007 17:33:58 +0100
References: <7zo1U-ht-9@gated-at.bofh.it> <7zoEG-1kW-19@gated-at.bofh.it> <7zF2R-1wJ-33@gated-at.bofh.it> <7zFvU-2p5-21@gated-at.bofh.it> <7zFFr-2AP-1@gated-at.bofh.it> <7zFYY-31i-19@gated-at.bofh.it> <7zGie-3Ji-17@gated-at.bofh.it> <7zGif-3Ji-21@gated-at.bofh.it> <7zGBC-49g-39@gated-at.bofh.it> <7zHnX-5rJ-25@gated-at.bofh.it> <7zI0B-6x2-5@gated-at.bofh.it> <7zI0B-6x2-3@gated-at.bofh.it> <7zIak-6JF-15@gated-at.bofh.it> <7zIak-6JF-13@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1H2s10-0001MH-Kk@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@gmx.de
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Sandeen <sandeen@redhat.com> wrote:
> Andrew Morton wrote:

>> +++ a/fs/bad_inode.c

>> -static int return_EIO(void)
>> +static long return_EIO(void)

> What about ops that return loff_t (64 bits) on 32-bit arches and stuff
> it into 2 registers....

*If* it uses an additional register for the high bits, it will set e.g.:
EDX << 32 | EAX == (s64) -EIO
 and therefore
EAX == -EIO // < -MAXLONGINT-1
EDX == -1

EAX will be the return register for s32. Therefore you can use one function
for both cases on i386:

long long f()
{
        return -42;
}

long      (*l )() = (void*)f; // hide warning
long long (*ll)() =        f;

int main(){
        printf("%ld %lld\n", l(), ll());
}

> I'm still not convinced that this is the best place to be clever :)

ACK, not too clever, but not too stupid, too. Having #ifdef I386 etc.
isn't nice, and something like this shouldn't be arch-specific.
OTOH, C calling convention allows having a different argument signature,
so you can safely use it. It's a feature.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
