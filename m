Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbVCOO1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbVCOO1t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 09:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbVCOO1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 09:27:49 -0500
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:2433 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S261275AbVCOO12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 09:27:28 -0500
Date: Tue, 15 Mar 2005 15:31:00 +0100 (CET)
From: Bodo Eggert <7eggert@gmx.de>
To: Albert Cahalan <albert@users.sf.net>
Cc: Bodo Eggert <7eggert@gmx.de>, Rene Scharfe <rene.scharfe@lsrfire.ath.cx>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] Make /proc/<pid> chmod'able
In-Reply-To: <1110854667.7893.203.camel@cube>
Message-ID: <Pine.LNX.4.58.0503151446140.2662@be1.lrz>
References: <1110771251.1967.84.camel@cube>  <42355C78.1020307@lsrfire.ath.cx>
 <1110816803.1949.177.camel@cube>  <Pine.LNX.4.58.0503142333480.6357@be1.lrz>
 <1110854667.7893.203.camel@cube>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(snipped the CC list - hope that's ok)

On Mon, 14 Mar 2005, Albert Cahalan wrote:
> On Tue, 2005-03-15 at 00:08 +0100, Bodo Eggert wrote:
> > On Mon, 14 Mar 2005, Albert Cahalan wrote:
> > > On Mon, 2005-03-14 at 10:42 +0100, Rene Scharfe wrote:
> > > > Albert Cahalan wrote:

> > NACK, the admin (and with the new inherited capabilities all users with 
> > cap_???_override) can see all processes. Only users who don't need to know
> > won't see the other user's processes.
> 
> Capabilities are too broken for most people to use.

That's being fixed, the new semantics will allow a wrapper.

> > > Note that the admin hopefully does not normally run as root.
> > 
> > su1 and sudo exist.
> 
> This is a pain.

mv ps ps.bin     # -+ or just ln -s /usr/bin/us1 ~admin/bin/ps instead
ln -s su1 ps     # /
echo $'\nask never\nalias ps /bin/ps\nallow admin prefix ps' >> /etc/su1.priv
# ore use * instead of admin, if all users are supposed to see everyone.

Or use the sysctl I described. It won't hurt more than the originally 
suggested flag, and it's much more powerfull.

> Now every user will need sudo access,
> and the sudoers file will have to disable requesting
> passwords so that scripts will work without hassle.

Is sudo _that_ bad? Seems it was a good decision to avoid sudo.

> > > Even if the admin were not running as a normal user, it is
> > > expected that normal users can keep tabs on each other.
> > > The admin may be sleeping. Social pressure is important to
> > > prevent one user from sucking up all the memory and CPU time.
> > 
> > Privacy is important, too. Imagine each user can see the CEO (or the
> > admin) executing "ee nakedgirl.jpg".
> 
> Obviously, he likes to have users see him do this.
> He'd use a private machine if he wanted privacy.

UNIX and linux are supposed to be a multi-user-systems unlike Win98.
Information leakage is usurally considered {\HUGE BAD}, and some security 
models demand closing all information leakages from privileged users to 
less privileged users. Restricted proc is one more step towards secure 
systems, unless you're depending on "peer review".

> > > > > Note: I'm the procps (ps, top, w, etc.) maintainer.
> > > > > 
> > > > > Probably I'd have to make /bin/ps run setuid root
> > > > > to deal with this. (minor changes needed) The same
> > > > > goes for /usr/bin/top, which I know is currently
> > > > > unsafe and difficult to fix.
> > 
> > I used unpatched procps 3.1.11, and it worked for me, except pstree.
> 
> It does not work correctly.
> 
> Look, patches with this "feature" are called rootkits.
> Think of the headlines: "Linux now with built-in rootkit".

Using another PC will hide the processes. Therefore using another PC is 
like using a rootkit. NOT.

Maybe you'll want to print a note about inaccessible proc entries, but 
that's a different issue.

> > > > Why do ps and top need to be setuid root to deal with a resticted /proc? 
> > > >     What information in /proc/<pid> needs to be available to any and all 
> > > > users?
> > > 
> > > Anything provided by traditional UNIX and BSD systems
> > > should be available.
> > 
> > e.g. the buffer overflow in sendmail? Or all the open relays? :)
> > 
> > The demands to security and privacy have increased. Linux should be able 
> > to provide the requested privacy.
> 
> This really isn't about security.

Information leakage is a security aspect.

> Privacy may be undesirable.

May. That's why I suggested the min/max sysctl.

> With privacy comes anti-social behavior.

With anti-social behavior comes the admin and his LART.

BTW: If the users want to be anti-social, they'll just rename setiathome 
to something like -bash or soffice.

> Supposing that the
> users do get privacy, perhaps because the have paid for it:

Vservers,
> Xen, UML, VM, VMware, separate computers
> 
> Going with separate computers is best.

If you like wasting space and energy. If the user's demands don't exceed 
one percent of a historic PC, there is no point in buying more hardware.

> Don't forget to use
> network traffic control to keep users from being able to
> detect the network activity of other users.

Like that:?

$ netstat
Active Internet connections (w/o servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State
/proc/net/tcp: Permission denied

> > > Users who want privacy can get their
> > > own computer. So, these need to work:
> > > 
> > > ps [...]
> > > w
> > > top
> > 
> > Works as intended. Only pstree breaks, if init isn't visible.
> 
> They work like they do with a rootkit installed.
> Traditional behavior has been broken.

They are as broken as finger or ls are if the home directory is chmodded.
-- 
Top 100 things you don't want the sysadmin to say:
13. Ooohh, lovely, it runs SVR4
