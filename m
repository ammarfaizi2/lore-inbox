Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262871AbTCFBIZ>; Wed, 5 Mar 2003 20:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267688AbTCFBIZ>; Wed, 5 Mar 2003 20:08:25 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:17171 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S262871AbTCFBIX>; Wed, 5 Mar 2003 20:08:23 -0500
Date: Wed, 5 Mar 2003 17:18:50 -0800
From: jw schultz <jw@pegasys.ws>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: About /etc/mtab and /proc/mounts
Message-ID: <20030306011850.GA16552@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <buon0kirym1.fsf@mcspd15.ucom.lsi.nec.co.jp> <3E5DCB89.9086582F@daimi.au.dk> <buo65r6ru6h.fsf@mcspd15.ucom.lsi.nec.co.jp> <20030227092121.GG15254@pegasys.ws> <20030302130430.GI45@DervishD> <3E621235.2C0CD785@daimi.au.dk> <20030303010409.GA3206@pegasys.ws> <3E634916.6AE643EB@daimi.au.dk> <20030304020203.GD7329@pegasys.ws> <3E65F454.825890F4@daimi.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E65F454.825890F4@daimi.au.dk>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 05, 2003 at 01:57:57PM +0100, Kasper Dupont wrote:
> jw schultz wrote:
> > Writing to /proc/mtab like we do /etc/mtab means allowing
> > full file read,write,truncate,seek functionality on a
> > multi-page tlob just to emulate current behavior and support
> > a second data source with a disconnect from the kernel.
> 
> I certainly don't want that. I'd much rather see something
> slightly similar to files in /proc/sys/. I only want the
> write system call to work, and I don't want the write call
> to make use of any file offset. (Maybe it would require a
> buffer for cases where a write does not end with a newline,
> but that is just a minor detail.) Every full line written
> to /proc/mtab would then be parsed (as simple as finding
> the spaces and verify that there are exactly five). The
> relevant fields in the mountpoint listed in field two will
> then be updated.

And umount?  Anything that umounts or remountes a filesystem
has to modify /etc/mtab to remove or alter the relevant
line.

I traced a umount and it did the write-to-temp+rename 
routine.  I wouldn't expect that to work to well in proc.
And you should have seen the ugly fstat64,_llseek,write
loop it used.

To put this in kernel means changing how it is updated.
Once we do that we might as well go all the way.

> > What i would lean towards, assuming that data couldn't list
> > all options not supported by mountflags would be to add a
> > char *userdata or useropts argument.  That would be attached
> > to struct vfsmount.  Userdata would be what /proc/mtab or
> > whatever reported, either as the option list or the whole
> > line.
> > 
> > To detect the old interface users a NULL userdata or (as
> > alternatives) a missing MS_USERDATA flag or calling the old
> > mount syscall would cause a warning that identifies the
> > offending process.  For the short term either construct a
> > fake userdata or mtab could fallback to what /proc/mounts
> > does when it hits NULL.  Long term might be to fail mount(2)
> > on such an error.
> 
> That is another possible solution. And as I think a litle
> more about it, that is probably a better than the solution I
> suggested.
> 
> There are a few details of the API that needs to be defined
> before it can be implemented. So I hope people will say how
> they like it. As I see it there are a few different
> possibilities:
> 
> 1) Make a new mount system call. Finally get rid of the old
>    magic value in the flag register and add the extra argument
>    which is then required. Make the old mount system call
>    obsolete, but keep it for some versions. The old mount
>    system call should then just behave as if the user data
>    was the empty string.
> 
> 2) Add a new flag for the old mount system call, which
>    indicates that there is one more argument containing the
>    user data.

#2 with warnings i like better than keeping a deprecated mount
syscall until 2038.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
