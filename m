Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132789AbRDQRks>; Tue, 17 Apr 2001 13:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132785AbRDQRk1>; Tue, 17 Apr 2001 13:40:27 -0400
Received: from thorin.y.ics.muni.cz ([147.251.61.126]:29956 "HELO
	charybda.fi.muni.cz") by vger.kernel.org with SMTP
	id <S132784AbRDQRkZ>; Tue, 17 Apr 2001 13:40:25 -0400
From: Jan Kasprzak <kas@informatics.muni.cz>
Date: Tue, 17 Apr 2001 19:40:19 +0200
To: Andi Kleen <ak@suse.de>
Cc: "David S. Miller" <davem@redhat.com>, pavel@janik.cz,
        linux-kernel@vger.kernel.org
Subject: Re: Possible problem with zero-copy TCP and sendfile()
Message-ID: <20010417194019.A2167@informatics.muni.cz>
In-Reply-To: <20010417151007.F916@informatics.muni.cz> <20010417164103.A9515@gruyere.muc.suse.de> <20010417175003.D2589096@informatics.muni.cz> <20010417175916.A11824@gruyere.muc.suse.de> <20010417190748.A2591015@informatics.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010417190748.A2591015@informatics.muni.cz>; from kas@informatics.muni.cz on Tue, Apr 17, 2001 at 07:07:48PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kasprzak wrote:
: $ cmp -cl seawolf-sendfile.iso seawolf-i386-SRPMS.iso
[...]
: 
: 	Which simply means, that at 160628609 it started to send
: the CD image from the beginning.

	Well, I did strace of proftpd, and it _may_ be a mis-interpretation
of the sendfile(2) semantics on the proftpd side. The relevant part
of strace follows:

gettimeofday({987527927, 46167}, NULL)  = 0
fcntl64(12, F_GETFL)                    = 0x802 (flags O_RDWR|O_NONBLOCK)
fcntl64(12, F_SETFL, O_RDWR)            = 0
sendfile(12, 9, [0], 678244352)         = 138133872
--- SIGALRM (Alarm clock) ---
rt_sigaction(SIGALRM, {0x804f520, [], SA_INTERRUPT|0x4000000}, NULL, 8) = 0
rt_sigaction(SIGALRM, NULL, {0x804f520, [], SA_INTERRUPT|0x4000000}, 8) = 0
rt_sigaction(SIGALRM, {0x804f520, [], SA_INTERRUPT|0x4000000}, NULL, 8) = 0
alarm(300)                              = 0
sigreturn()                             = ? (mask now [])
fcntl64(12, F_SETFL, O_RDWR|O_NONBLOCK) = 0
alarm(0)                                = 300
alarm(300)                              = 0
alarm(0)                                = 300
alarm(300)                              = 0
getpid()                                = 24482
geteuid32()                             = 14
getegid32()                             = 50
flock(6, LOCK_EX)                       = 0
lseek(6, 644, SEEK_SET)                 = 644
read(6, "\242_\0\0\16\0\0\0002\0\0\0\0\0\0\0I\10\0\0\0\0\0\0ftp"..., 644) = 644
lseek(6, 644, SEEK_SET)                 = 644
write(6, "\242_\0\0\16\0\0\0002\0\0\0\0\0\0\0I\10\0\0\0\0\0\0ftp"..., 644) = 644
flock(6, LOCK_UN)                       = 0
fcntl64(12, F_GETFL)                    = 0x802 (flags O_RDWR|O_NONBLOCK)
fcntl64(12, F_SETFL, O_RDWR)            = 0
sendfile(12, 9, [0], 540110480)         = 103469424

	Now the fd 6 is the control connection, fd 9 is the file on disk,
and fd 12 is the data connection. The ProFTPd seems to set alarm to 300
seconds (to detect stalled clients), but when interrupted, something strange
happens: either sendfile does not update the offset in its third parameter,
or it fails to update the offset in the filedescriptor, or something like that.
Maybe ProFTPd should pass the non-zero value (actual offset?) to sendfile()
second time?

	What is the expected semantics of sendfile() wrt. restarting
transfers and being interrupted by SIGALRM?

-Yenya

-- 
\ Jan "Yenya" Kasprzak <kas at fi.muni.cz>       http://www.fi.muni.cz/~kas/
\\ PGP: finger kas at aisa.fi.muni.cz   0D99A7FB206605D7 8B35FCDE05B18A5E //
\\\             Czech Linux Homepage:  http://www.linux.cz/              ///
Mantra: "everything is a stream of bytes". Repeat until enlightened. --Linus
