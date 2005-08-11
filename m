Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964846AbVHKM10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbVHKM10 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 08:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbVHKM10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 08:27:26 -0400
Received: from imap.gmx.net ([213.165.64.20]:25771 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964846AbVHKM10 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 08:27:26 -0400
Date: Thu, 11 Aug 2005 14:27:24 +0200 (MEST)
From: "Michael Kerrisk" <mtk-lkml@gmx.net>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: peterc@gelato.unsw.edu.au, linux-kernel@vger.kernel.org,
       sfr@canb.auug.org.au, matthew@wil.cx, michael.kerrisk@gmx.net
MIME-Version: 1.0
References: <1123761105.8251.10.camel@lade.trondhjem.org>
Subject: =?ISO-8859-1?Q?Re:_fcntl(F_GETLEASE)_semantics=3F=3F?=
X-Priority: 3 (Normal)
X-Authenticated: #23581172
Message-ID: <24699.1123763244@www9.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Von: Trond Myklebust <trond.myklebust@fys.uio.no>
> to den 11.08.2005 Klokka 10:14 (+0200) skreiv Michael Kerrisk:
> 
> > No.  The behavior in Linux recently, and arbitrarily (IMO) changed:
> 
> The change was NOT arbitrary. 

Okay -- I'm puzzled.  Two of the people that I understand to have
had a strong interest in file leases seemed to think the change 
shouldn't have occurred:

Stephen Rothwell: 
http://marc.theaimsgroup.com/?l=linux-kernel&m=111512619520116&w=2

    Thanks for the testing.  My expectation is that it shouldn't 
    matter how the current process opened the file for either 
    type of lease.  However, you are right (IMHO) that the current 
    process should *not* be counted as a writer in the case of 
    trying to obtain a F_RDLCK lease.

And Stephen suggested a one line patch to fix the problem

Matthew Wilcox also wrote:
http://marc.theaimsgroup.com/?l=linux-kernel&m=111512898520775&w=2

    On Tue, May 03, 2005 at 09:55:42AM -0400, William A.(Andy) 
    Adamson wrote:
    > i believe the current implementation is correct. opening a 
    > file for write means that you can not have a read lease, 
    > caller included.

    Why not?  Certainly, others will not be able to take out a 
    read lease, so there's very little point to only having a 
    read lease, but I don't see why we should deny it.

(By the way, I wrote the fcntl.2 manpage text for file 
leases -- because there was no existing documentation, or 
specification of the desired behavior; the text was based 
on my experiments, and some email discussions with Stephen 
Rothwell.)

And I pointed out that the existing behaviour (which is 
still current in 2.6.13-rc4) is inconsistent:

http://marc.theaimsgroup.com/?l=linux-kernel&m=111511455406623&w=2

    Some further testing showed the following (both open() 
    and fcntl(F_SETLEASE) from same process):

     open()  |  lease requested
      flag   | F_RDLCK  | F_WRLCK
    ---------+----------+----------
    O_RDONLY | okay     |  okay
    O_WRONLY | EAGAIN   |  okay
    O_RDWR   | EAGAIN   |  okay

In other words, a process can open a file read-write, and
can't place a read lease, but can place a write lease!  
That does not seem to make any sense to me.

> It was deliberate and for the reasons
> stated.

Can you elaborate -- which reasons are you referring to?  

> The whole point of leases is to support CIFS oplocks for Samba and NFSv4
> delegations in the kernel. 

Yep, I understand that much.

> Both have the same specific expected
> behaviour.
> The original deviates from that expected behaviour by allowing you to
> get a shared lease when in a condition that does not allow actual
> sharing.

And I should add -- I know little about SAMBA or CIFS.  But from 
what I've seen (the quoted messages above), the change seems to 
have been accidental, and inconsistent.

Cheers,

Michael

-- 
5 GB Mailbox, 50 FreeSMS http://www.gmx.net/de/go/promail
+++ GMX - die erste Adresse für Mail, Message, More +++
