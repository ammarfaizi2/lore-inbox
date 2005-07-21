Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261915AbVGUWjD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbVGUWjD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 18:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbVGUWjC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 18:39:02 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:19607 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261915AbVGUWie (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 18:38:34 -0400
Subject: Re: CIFS slowness & crashes
From: Steve French <smfltc@us.ibm.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Lasse =?ISO-8859-1?Q?K=E4rkk=E4inen?= / Tronic 
	<tronic+lzID=lx43caky45@trn.iki.fi>,
       linux-kernel@vger.kernel.org, linux-cifs-client@lists.samba.org
In-Reply-To: <9a87484905072115041cc576a4@mail.gmail.com>
References: <42E01163.3090302@trn.iki.fi>
	 <9a87484905072115041cc576a4@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Organization: IBM - Linux Technology Center
Message-Id: <1121985312.26833.28.camel@stevef95.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 21 Jul 2005 17:35:12 -0500
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-21 at 17:04, Jesper Juhl wrote:
> On 7/21/05, Lasse Kärkkäinen / Tronic <tronic+lzID=lx43caky45@trn.iki.fi> wrote:
> > I mailed sfrench@samba.org (the guy who wrote the driver) about this a
> > month ago, but didn't get any reply. Is anyone working on that driver
> > anymore?
> > 
> As far as I know Steve is still maintaining cifs. If you wrote him and
> didn't get a response, then try again after a while (you might have
> included him on CC for this mail) - maintainers don't always have time
> to answer all mail in a timely fashion (or at all), and it's your
> responsability to resend - that's not news.

CIFS is still being actively improved/maintained.  I was out on vacation
for over a week.  It might have gotten missed in the flood of email I
had to catch up on.  I am still maintaining cifs and evaluating patches
from others as well.  As you can see from the web git page, changesets
are still being added.  You can see the list of CIFS changesets (most
recent first) by the query:
	http://www.kernel.org/git/?p=linux%2Fkernel%2Fgit%2Fsfrench%2Fcifs-2.6.git&a=search&s=CIFS

> You could also have written to the samba-technical@lists.samba.org
> mailinglist (or copied it - it's listed in MAINTAINERS under "COMMON
> INTERNET FILE SYSTEM (CIFS)").
> 
> [adding Stephen French to CC]
> 
> Personally I'd probably have send the mail
>  To: Steve French <sfrench@samba.org>
>  Cc: samba-technical@lists.samba.org
>  Cc: linux-kernel@vger.kernel.org

Yes.  CCing those lists is recommended.  The best list to send to is and
which I and others in this area monitor regularly though is
linux-cifs-client@lists.samba.org

> > not possible to umount with either smbumount (hangs) 
smbumount can not be called on cifs vfs mounts (it is for the older
smbfs).  Although there is a somewhat similar umount.cifs utility
(umount.cifs.c in the samba 3 source) it will be obsolete when 
more general user umounting (of their own mounts) is permitted
in the kernel vfs itself.

> nor umount -f
> > (prints errors but doesn't umount anything). 

What are the errors?  What is the version of cifs.ko module?

> It won't recover without
> > reboot, even if the server becomes back online.
> > 
> > This problem has been around as long as I have used SMBFS or CIFS. There
> > has only been slight variation from one version to another. Sometimes it
> > is possible to umount them (after some pretty long timeout), sometimes
> > it is not. It seems as if the problem was being fixed, but none of the
> > fixes really worked.

My tests of reconnection after server crash or network reconnection with
smbfs works (for the past year or two) and also of course for cifs. 
cifs also reconnects state (open files) not just the connection to
\\server\share


> > 
> > 2. Occassionally the transmission speeds go extremely low for no
> > apparent reason. While writing this, I am getting 0.39 Mo/s over a
> > gigabit network.

My informal tests (cifs->samba) showed a maximum of about 20%
utilization of gigabit doing large file writes and about double that for
large file reads with a single cifs client to Samba over gigabit. Should
be somewhat simalar to Windows server.

The most common cause of widely varying speeds are the following:
1) memory fragmentation - some versions of the kernel badly fragment
slab allocations greater than 4 pages (cifs by default allocates 16.5K
buffers - which results in larger size allocations when more than 5
processes are accessing the mount and the cifs buffer pool is exceeded)
2) write behind due to oplock - smbfs does not do oplock, cifs does -
which means that cifs client caching can cause a large amount of
writebehind data to accumulate (with great performance for a while) -
then when memory gets tight due to the inode caching in linux's mm
layer, the cifs client is asked to write out a large amount of file data
at one time (which it does synchronously). 

Both of these are being improved.  You can bypass the inode caching on
the client by using the cifs mount option
	"forcedirectio"


>  Using FTP to read the same file gives 40 Mo/s,
Similarly NFS was somewhat better than that (as long as the file was in
memory already on the server).



