Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263614AbTETHbA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 03:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbTETHbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 03:31:00 -0400
Received: from netmail02.services.quay.plus.net ([212.159.14.221]:12258 "HELO
	netmail02.services.quay.plus.net") by vger.kernel.org with SMTP
	id S263614AbTETHa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 03:30:58 -0400
From: "Riley Williams" <Riley@Williams.Name>
To: "David Woodhouse" <dwmw2@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: Recent changes to sysctl.h breaks glibc
Date: Tue, 20 May 2003 08:44:01 +0100
Message-ID: <BKEGKPICNAKILKJKMHCAGECEDBAA.Riley@Williams.Name>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <1053392095.21582.48.camel@imladris.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David.

 >> Your message assumes that the ABI remains fixed. This is
 >> totally and utterly and undeniably WRONG. There are rules
 >> for how it may evolve, but it very much does evolve. No
 >> amount of hand-waving or putting underscores in weird
 >> places will change that.

 > To a large extent, however, it merely grows. And in a lot
 > of cases when it grows due to new syscalls, new interfaces,
 > etc., you have to add matching code to glibc to use them
 > _anyway_, so it's no problem for glibc's version of the
 > headers to lag behind until the appropriate support is
 > added.
 >
 > You are, however, correct that the correct fix is to have
 > completely separate headers which define the ABI. Then
 > the real kernel headers in include/linux and include/asm
 > can include them, and C libraries can also use them without
 > contamination.

First, is there anything in include/asm that is actually needed
outside the kernel itself? There shouldn't be, and if there is,
it needs to be moved to a header under include/linux that is
included in the relevant include/asm file.

Assuming that has been done, the first step in making this
change would be to create the directory all this is to go into.
Any suggestions ???

My suggestion would be to move the current headers to a new
directory and put the public headers in their place. This
would produce the following include directory layout:

 * include/linux/    The "sanitised" header files that are
                     safe for use by external software.

 * include/kernel/   Versions of those header files that are
                     used by the kernel, each including the
                     relevant sanitised header files.

 * include/asm/      Header files used only by the kernel,
                     all including the relevant sanitised
                     header files.

The basic rule would be that external software can make free
use of headers under include/linux but should never make any
use whatsoever of headers under include/kernel or include/asm
for any reason.

If anything external to the kernel needs to refer to something
only defined under include/kernel/ then they should report that
here for consideration as something needing a sanitised version
and we could thus ensure that any oversights were dealt with.

 > This requires that someone sit down and cut'n'paste large
 > amounts of structures and definitions from include/linux/*.h
 > into the new header files. I've been tempted to do that on
 > occasion but what's held me up has been the fact that there
 > isn't yet a consensus on how it should be laid out.

Personally, I'm of the opinion that this will only be resolved
when somebody sits down and just does it as they see fit.

 > For compatibility with older libc, one approach would be to
 > add a new directory to the include path which matches the
 > existing layout (linux/usrinclude/linux, linux/usrinclude/asm-*),
 > and use #include_next from the actual kernel headers to pull in
 > those files.

 > Alternatively, we could go further and take the opportunity
 > to rearrange stuff further; I'm not sure what we really gain
 > from that though other than extra pain.

I personally can't see the point of that.

 > If Linus would approve a strategy for rearranging the headers
 > such that people can work on it without suspecting that they're
 > just wasting their time, I think it could get done for 2.6.
 >
 > It's not the kind of thing you do in private and present as a
 > fait accompli -- if it isn't quite right, you end up having
 > to do the whole thing from scratch, afaict.

The only way I can see this ever being done is one header at a time.
I'm willing to have a go at doing this along the lines of the above
scheme, and the first patch would be one to create the directory
with a set of empty files therein.

Best wishes from Riley.
---
 * Nothing as pretty as a smile, nothing as ugly as a frown.

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.481 / Virus Database: 277 - Release Date: 13-May-2003

