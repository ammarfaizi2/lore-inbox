Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266456AbRGLRgp>; Thu, 12 Jul 2001 13:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266459AbRGLRgg>; Thu, 12 Jul 2001 13:36:36 -0400
Received: from Srg.access.comstar.ru ([195.210.131.190]:7808 "EHLO
	backtop.namesys.com") by vger.kernel.org with ESMTP
	id <S266456AbRGLRgR>; Thu, 12 Jul 2001 13:36:17 -0400
Message-ID: <3B4DDFD8.27C1C3D9@namesys.com>
Date: Thu, 12 Jul 2001 21:35:20 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: LA Walsh <law@sgi.com>
CC: Linus Torvalds <torvalds@transmeta.com>, reiserfs-dev@namesys.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
Subject: Re: Security hooks, "standard linux security" & embedded use
In-Reply-To: <3B49F602.DB39B3A@sgi.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linda,

This seems very much in line with what Reiser4 is doing for DARPA, and what SE Linux is doing for
the NSA.  Or at least what Linus told the SE Linux folks he would like them to write.:-)

I am quite supportive of what you advocate generally, and I look forward to cooperating with you in
the details.

May I suggest we contact the SE Linux folks, and each of our teams establish a point-of-contact to
work on
developing the details of what needs to be done?

We call your security hooks "security plugins" or "secplugs" in Reiser4, mostly to identify that
they are a component of the Reiser4 "plugin" approach to extensibility.  Reiser4 is getting underway
this month.  We are willing to adapt our terminology and coding to be be consistent with yours.  We
don't really have a need to be the leaders in this area.  We just need to get the job done, and to
ensure that nothing that is done crimps our ability to accomplish our objectives.  Our project
objectives are somewhat describable as "make it easy for folks like the NSA and the DoD to add new
security features to Reiser4 by building the infrastructure for them."  We will ship one
implementation on top of that infrastructure that will implement ACLs, but we are more interested in
enabling others than in doing ourselves.  If the NSA or SGI wants to lead us a bit on this, that is
fine with us.  Our main insistence is going to be that the hooks should be very general, but I
suspect you and the NSA also want that.  We also need to have coding completed in ~8 months, so that
it can all be debugged and stable and sent to Linus by Sep. 30th of next year.

Do you have a list of all the hooks, etc., yet?  Do you have anything like a general architecture
for, given some vfs operation, and given some pluginid indicating object type, and given some
secplugid  (e.g. it might be the id of a secplug implementing an ACL), have the plugin check that
the operation is allowable by calling the secplug (security hook) indicated by the secplugid?

I think what is needed is an MxN matrix of security checks, where M is the number of vfs operations,
and N is the number of secplugs.  I am open to the idea that it should be MxNxO, where O is the
number of security policies, though I don't plan to personally implement more than one security
policy to ship with Reiser4 by default because I am pretty lazy.  It won't surprise me if I end up
shipping only one secplug with reiser4 initially (probably one implementing something embodying NT
ACLs and unix permissions), and leave it to others to add the rest of them).  

I am quite supportive of your notion that some users have no need at all for security, and that they
should be allowed a lightweight solution for their needs, though I will leave it to them to write
that on top of the infrastructure I/we give them.:-)  I envision the VFS operation invoking the
plugin which invokes the secplug whose implementation varies with the choice of security policy
compiled in.  I don't honestly see the real usage critical need for dynamic loading of security
policy modules, but I can yield on this if you see the need and code it since it probably isn't
complex to code.  I do like the idea of all of the code implementing a given security policy being
isolated into its own single file/directory.

Do you have any ideas on how to export to user space the ability to query what the permissions are,
given that the permissions are being abstracted like this?

I got your email, but I wasn't on the to: or cc: list.  This confused me, so I invented a to: list
that should reach all those likely to be interested in this.  I am guessing this will be okay with
you.

Best,

Hans

LA Walsh wrote:
> 
> Dear Linus et al.,
> 
>         Sorry for the 'form' letter instead of individual names, but I
> didn't want to have to send this out separately to every kernel developer
> I know on LKML.
> 
>         I am asking for your input on the concept of moving the standard
> Linux security checks into a "Linux Security Module".
> 
>         Discussion has come up on the Linux Security Module list
> about whether or not the current linux security (file mode bits, uid
> checking, etc.) should be modularized in the development of an LSM
> framework implementation
> 
>         This would entail moving all of the standard checks out of the
> kernel into a "standard security" module that, by default, would be
> the security policy selected and compiled in during kernel configuration
> and build.
> 
>         This seems to us (@sgi) to be the best solution to allow a
> completely configurable security policy.  This option allows
> a policy creator complete flexibility in how or whether or not
> existing security is called.  For example, in POSIX 1e style Mandatory
> Access Control, the information in the inode is also part of the
> protected object.  So if a process doesn't have access under MAC, the
> DAC checks wouldn't even be executed since it doesn't have
> access to the permission bits, owner and group info in order to
> perform a DAC check.  Some security policies may wish to be called
> conditionally after the existing security is checked.
> 
>         Most importantly, this implementation addresses the needs of
> the embedded market by allow them to remove some or all of the existing
> checks.  I believe Linus mentioned that some embedded developers didn't
> even want the security that was already present.  They might have no need
> for separate users or non-root users.  Just "1" user id that is
> always running out of ROM in root mode (i.e. everything is permitted).
> This proposed implementation allows them to save both the memory,
> a critical resource for some embedded systems) as well as the
> execution time spent doing the standard checks.
> 
>         It has come up on the list that such an implementation would never
> be accepted by the "Kernel developers" as being too invasive.  However
> we believe 2.5 would be the perfect place to develop and implement
> such a scheme.
> 
>         So I am unofficially soliciting feedback from various kernel
> developers to ascertain if the statement about the "kernel developers"
> is widely held, or made by a select few purporting to represent the whole.
> Others on the list would like apriori approval by the "Linux Kernel
> developers" before embarking on such a bold implementation.
> 
>         Your comments, opinion and, even, buy-in (if you want this)
> would be invaluable.  If you wish to chime in directly the
> list archives and subscription info is at:
> 
> http://mail.wirex.com/mailman/listinfo/linux-security-module
> 
> Thank-you.
> 
> Sincerely,
> Linda Walsh
> --
> L A Walsh, law at sgi.com         | Sr Eng, Trust Technology
> 01-650-933-5338                   | Core Linux, SGI
