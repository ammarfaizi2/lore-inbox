Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265334AbSKEXTX>; Tue, 5 Nov 2002 18:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265336AbSKEXTX>; Tue, 5 Nov 2002 18:19:23 -0500
Received: from almesberger.net ([63.105.73.239]:44297 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S265334AbSKEXTV>; Tue, 5 Nov 2002 18:19:21 -0500
Date: Tue, 5 Nov 2002 20:25:38 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: ebiederm@xmission.com, Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: [lkcd-devel] Re: What's left over.
Message-ID: <20021105202538.J1408@almesberger.net>
References: <Pine.LNX.4.44.0210310918260.1410-100000@penguin.transmeta.com> <3DC19A4C.40908@pobox.com> <20021031193705.C2599@almesberger.net> <20021105171230.A11443@in.ibm.com> <20021105150048.H1408@almesberger.net> <1036521360.5012.116.camel@irongate.swansea.linux.org.uk> <20021105161902.I1408@almesberger.net> <1036527046.6750.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036527046.6750.16.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Tue, Nov 05, 2002 at 08:10:46PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>  - a system call to set it up
> 
> Device, file, insmod...

I don't know what Eric thinks about using something else than a
system call, but I think he made a quite reasonable choice.

The data structure isn't entirely trivial, so a misc device plus
ioctl would be a bit on the ugly side. I vaguely remember having
proposed something like this a while ago (may have been for
pivot_root), and everybody went "noooo!!" ;-)

insmod would be possible, although with a rather unusual parameter
passing scheme. Also, when using kexec from inside the kernel (e.g.
MCORE), the insmod solution would have to split kexec into the
interface and the kexec core.

But yes, there's always a means to avoid adding a new system
call. /dev/syscall with an ioctl

struct syscall_ioctl {
	const char *symbol_name;
	va_list ap;
};

anyone ? :-) (Implementing it might be a bit of a challenge :)

> So you need to register with the power management as the last thing to
> be suspended and do a suspend before kexec.

Well, kexec just calls device_shutdown. The problem isn't the
interface, it's that device_shutdown apparently doesn't work too
well (devices not supporting it, some semantics mixup, etc.).
But this is general infrastructure work, that should be done
with or without kexec.

> I'm mostly worried about how to make these things fit the least
> intrusively into the kernel.

Just look at Eric's kexec patch. It isn't particularly intrusive:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103604471723358&w=2

(For 2.5.45. The patch fails for 2.5.46, because new system calls
were added ...)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
