Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261908AbTCEMrg>; Wed, 5 Mar 2003 07:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264729AbTCEMrg>; Wed, 5 Mar 2003 07:47:36 -0500
Received: from daimi.au.dk ([130.225.16.1]:41432 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S261908AbTCEMre>;
	Wed, 5 Mar 2003 07:47:34 -0500
Message-ID: <3E65F454.825890F4@daimi.au.dk>
Date: Wed, 05 Mar 2003 13:57:57 +0100
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.18-19.7.xsmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jw schultz <jw@pegasys.ws>
CC: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: About /etc/mtab and /proc/mounts
References: <buoy942s6lt.fsf@mcspd15.ucom.lsi.nec.co.jp> <3E5DB2CA.32539D41@daimi.au.dk> <buon0kirym1.fsf@mcspd15.ucom.lsi.nec.co.jp> <3E5DCB89.9086582F@daimi.au.dk> <buo65r6ru6h.fsf@mcspd15.ucom.lsi.nec.co.jp> <20030227092121.GG15254@pegasys.ws> <20030302130430.GI45@DervishD> <3E621235.2C0CD785@daimi.au.dk> <20030303010409.GA3206@pegasys.ws> <3E634916.6AE643EB@daimi.au.dk> <20030304020203.GD7329@pegasys.ws>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jw schultz wrote:
> 
> I had read all you wrote in this thread.  I'll grant that i
> might have missed what you wrote elsewhere or perhaps what you
> implied.

Hmm, maybe it was somewhere else I wrote it then.

> 
> Writing to /proc/mtab like we do /etc/mtab means allowing
> full file read,write,truncate,seek functionality on a
> multi-page tlob just to emulate current behavior and support
> a second data source with a disconnect from the kernel.

I certainly don't want that. I'd much rather see something
slightly similar to files in /proc/sys/. I only want the
write system call to work, and I don't want the write call
to make use of any file offset. (Maybe it would require a
buffer for cases where a write does not end with a newline,
but that is just a minor detail.) Every full line written
to /proc/mtab would then be parsed (as simple as finding
the spaces and verify that there are exactly five). The
relevant fields in the mountpoint listed in field two will
then be updated.

> > >
> > > mount(8) and umount(8) are the only almost the only things that
> > > write mtab all others are readers.
> >
> > What are you saying? Are they the only writers, or are there
> > other writers? IIRC smbmount will write /etc/mtab on its own.
> 
> Hence the qualifier.  My point is that the list of things
> that call mount(2) directly and write to /etc/mtab is small
> and the most critical of them are linux specific.  This
> gives us a degree of freedom in our approach.

We agree on that.

> 
> What i would lean towards, assuming that data couldn't list
> all options not supported by mountflags would be to add a
> char *userdata or useropts argument.  That would be attached
> to struct vfsmount.  Userdata would be what /proc/mtab or
> whatever reported, either as the option list or the whole
> line.
> 
> To detect the old interface users a NULL userdata or (as
> alternatives) a missing MS_USERDATA flag or calling the old
> mount syscall would cause a warning that identifies the
> offending process.  For the short term either construct a
> fake userdata or mtab could fallback to what /proc/mounts
> does when it hits NULL.  Long term might be to fail mount(2)
> on such an error.

That is another possible solution. And as I think a litle
more about it, that is probably a better than the solution I
suggested.

There are a few details of the API that needs to be defined
before it can be implemented. So I hope people will say how
they like it. As I see it there are a few different
possibilities:

1) Make a new mount system call. Finally get rid of the old
   magic value in the flag register and add the extra argument
   which is then required. Make the old mount system call
   obsolete, but keep it for some versions. The old mount
   system call should then just behave as if the user data
   was the empty string.

2) Add a new flag for the old mount system call, which
   indicates that there is one more argument containing the
   user data.

> 
> I think our goals are the same.

Yes.

> The only reason i chimed in
> on this discussion was to remind people that /etc/mtab was a
> hack we no longer really need and then because it sounded
> like what was being proposed was to emulate that
> obsolescence with another layer of cruft.

I never wanted a /proc/mtab to emulate the existing /etc/mtab.
In fact I wanted it to resemble the existing /proc/mounts as
much as possible, just with a few new features and probably
a different string in the device field in some cases.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:aaarep@daimi.au.dk
for(_=52;_;(_%5)||(_/=5),(_%5)&&(_-=2))putchar(_);
