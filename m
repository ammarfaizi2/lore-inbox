Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbVKUQFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbVKUQFQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 11:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbVKUQFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 11:05:16 -0500
Received: from ms-smtp-03.texas.rr.com ([24.93.47.42]:14573 "EHLO
	ms-smtp-03-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S932304AbVKUQFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 11:05:14 -0500
Message-ID: <4381EFF3.8000201@austin.rr.com>
Date: Mon, 21 Nov 2005 10:04:03 -0600
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, eric2.valette@francetelecom.com,
       torvalds@osdl.com
Subject: Re: CIFS improvements/wider testing needed
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric,
Thanks for the feedback - any bugs which you report which I can 
reproduce - I will treat
as a very high priority and your testing is helpful.

 > Trying to push Linux in corporate environments in such condition is very
 > difficult because, due to those bugs, you cannot:
 >
 >       1) save a new openoffice document twice,
 >         2) create mail folders from inside thunderbird (local mailbox 
shared
 > with windows),

You can avoid these by mounting with "nobrl" (no remote byte range lock) 
mount option
(smbfs does not send byte range locks so would not run into this 
problem, but would run
into others).    These appear to be byte range locking problems. The 
problem is that cifs has
to map advisory to mandatory locks which only works if the application 
is reasonably well
behaved (not even Samba has support for advisory locks although
they will come with the new Unix extensions). It may be made worse by a 
bug in openoffice
(some Linux apps such as Evolution lock on the "wrong" file handle which 
does not fail in posix,
although is sloppy coding) but I have not confirmed the byte range lock 
sequence which
openoffice is trying as we did with Evolution - I did confirm that nobrl 
(disabling the
byte range locks on the client) works.  Note that this mount option, 
although not listed
as a  bug fix in git per-se - was added to address the evolution etc. 
locking bugs.  There
are quite a few of the cifs changes that fall into that category.

 >         3) avoid to do FSCK after each reboot,
Not sure that cifs would cause this unless you mean that cifs was hung 
and shutdown hung.   To
avoid cases where cifs requests could stay blocked forever (especially 
locking requests),
I added a umount_begin routine a few weeks ago to try to free threads 
blocked in cifs -
but what I need from users/tests if they see a cifs umount fail is to 
know where the requests
are hung so I can add wakeup calls for that condition in
cifs's umount_begin (you can do "echo t > /proc/sysrq-trigger" then 
"dmesg > debugdata" to get
the debugdata which has the callstacks of processes blocked in kernel).

 > I've seen many changes going in CIFS git tree during this period but
 > only few bugs got really hunted and fixed
Scanning the bugzilla list I don't see many which are still believed to 
be valid, but
the bugzilla list for cifs on bugzilla.samba.org needs to be cleaned up.

 >SMBfs do not exibit some of the bugs CIFS has but has other limitations
SMBfs runs far fewer posix applications.   The main advantage smbfs
has is in its kerberos support (which is being worked with the new cifs
upcall) and in that it cheats and opens multiply open files only once and
with the wrong flags (which can help performance in some cases
but the lack of safe caching can lead to data corruption).

 >Could other on the LKML list try to reproduce/confirm the following bugs
 >with the latest snapshot:
That would be very helpful.

 > NB : the second bug appeared with CIFS 1.39 and is not present in 
2.6.14.2
 >
The smb length checking code was fixed in cifs 1.38 or cifs 1.39 (it was 
missing some
illegal cases where tcp length of the smb did not match the calculated 
smb length of
the three parts of the smb).   It of course could be a security exposure to
overly relax the length checking code on incoming
network buffers.  Unfortunately Windows server has at least one bug in which
its server miscalculates the size of an smb with no data area but an
illegal pad but the empty bcc (byte data) area of an SMB - this can 
occur on
byte range locks but we may be seeing a second case in your example. 

 > BUGS :
 >         <https://bugzilla.samba.org/show_bug.cgi?id=2673>
I suspect that this is a difference in default ACLs or share permissions 
on the windows server side, but
as I have mentioned additinal data would be helpful as no one else so 
far has been able to reproduce it
as far as I know.   If that is not the cause it may be a problem with 
the emulation of Linux mode
bits - and of course some three or four of the most recent cifs changes 
have been working case by
case through improving this to Windows servers.  It is not easy code to 
discover and write.

 >         <https://bugzilla.samba.org/show_bug.cgi?id=3237>
I would like to see the debug data ("cat /proc/fs/cifs/DebugData") so I 
can see if there any
pending network requests when your shutdown occurs - and I want to see 
an ethereal trace
(or tcpdump or equivalent binary trace file) of this so I can see what 
is going on with this
malformed response from the server.

 > May I suggest to fix bugs as a priority before adding new features for a
If there is a known bug, reported and which I can recreate - it is of 
course my highest priority
and I would also evaluate patches to fix such as my highest priority - 
but if they are hard
or impossible for me to recreate - getting the very, very, very hot 
issue of Kerberos security
enablement finished is the priority now.

 > Or at least make sure enough testing is done to avoid regressions?
There is a large test suite of the typical Linux fs tests (connectathon 
posix file api,
fsx, fsstress, dbench, etc.) which is run against Samba and Windows on 
every
update of cifs (by me and Shaggy and others who can help from time to time).
I would love additional testing in the user community especially on a 
broader set of servers
than I can test - one person can't possibly have enough servers to test 
every one of the
variations of  Windows servers or even Samba/unix platform variants - 
and there
are dozens of other nas appliances and cifs servers.
 
Although I would like to find a workaround so it does not hang the 
umount or fail umount
I am not convinced that this is a typical regression - if a server sends 
an illegal response which
we were not catching before ... it would be dangerous to call preventing 
that potential
security problem a regression.

