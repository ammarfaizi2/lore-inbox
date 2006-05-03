Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965212AbWECPAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965212AbWECPAb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 11:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965213AbWECPAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 11:00:30 -0400
Received: from nz-out-0102.google.com ([64.233.162.202]:11818 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965212AbWECPAa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 11:00:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kEbFbSfG4ktVLbhcAyxITcQ8afjtEpDLTSm3DujoOOP2wKrgoiSWsZ0W5IEn+/3MRsSKGqAA1fLY6LHOGVm50PhnC4jegU4AOVtqhaqMWsKhqFtOCsX32pWWE/zWnqjHGDWE203EieLFJq27uZIjgacct6LV5HmKd9F9oe9/A/4=
Message-ID: <9e4733910605030800i4f7e7444qe63b5daee2f1773b@mail.gmail.com>
Date: Wed, 3 May 2006 11:00:29 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: [PATCH 11/14] Reworked patch for labels on user space messages
Cc: "Al Viro" <viro@ftp.linux.org.uk>, "Ingo Molnar" <mingo@elte.hu>,
       "Steve Grubb" <sgrubb@redhat.com>, "Andrew Morton" <akpm@osdl.org>,
       "James Morris" <jmorris@namei.org>, linux-kernel@vger.kernel.org,
       "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <1146667956.27735.73.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <E1FaVfH-000531-LX@ZenIV.linux.org.uk>
	 <9e4733910605030711p2acab747g8f2ea7fdbb95f3c4@mail.gmail.com>
	 <20060503142802.GD27946@ftp.linux.org.uk>
	 <1146667956.27735.73.camel@moss-spartans.epoch.ncsc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can boot again with this patch...

On 5/3/06, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Wed, 2006-05-03 at 15:28 +0100, Al Viro wrote:
> > On Wed, May 03, 2006 at 10:11:52AM -0400, Jon Smirl wrote:
> > > Something seems to be wrong in selinux_get_task_sid. I am getting
> > > thousands of these and can't boot the kernel.
> >
> > It's actually in security/selinux/hooks.c::selinux_disable() and gets
> > triggered if you have selinux enabled and explicitly disable afterwards.
> > Stephen Smalley had done a fix yesterday, basically adding
> >       selinux_enabled = 0;
> > after
> >         selinux_disabled = 1;
> > in there.  selinux_get_task_sid() happens to step on that in visible way
> > and nobody had caught that while this stuff was sitting in -mm ;-/
> >
> > The only question I have about that patch: what would happen if we do not
> > have CONFIG_SECURITY_SELINUX_BOOTPARAM?  In that case selinux_enabled is
> > defined to 1, so...
>
> Good point.  Ok, take two.
>
> [patch 1/1] selinux:  Clear selinux_enabled flag upon runtime disable.
>
> Clear selinux_enabled flag upon runtime disable of SELinux by userspace,
> and make sure it is defined even if selinux= boot parameter support is
> not enabled in configuration.
>
> Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
>
> ---
>
>  security/selinux/hooks.c            |    3 +++
>  security/selinux/include/security.h |    5 -----
>  2 files changed, 3 insertions(+), 5 deletions(-)
>
> diff -X /home/sds/dontdiff -rup linux-2.6.17-rc3-mm1/security/selinux/hooks.c linux-2.6.17-rc3-mm1-x2/security/selinux/hooks.c
> --- linux-2.6.17-rc3-mm1/security/selinux/hooks.c       2006-05-02 09:08:02.000000000 -0400
> +++ linux-2.6.17-rc3-mm1-x2/security/selinux/hooks.c    2006-05-03 10:26:43.000000000 -0400
> @@ -101,6 +101,8 @@ static int __init selinux_enabled_setup(
>         return 1;
>  }
>  __setup("selinux=", selinux_enabled_setup);
> +#else
> +int selinux_enabled = 1;
>  #endif
>
>  /* Original (dummy) security module. */
> @@ -4535,6 +4537,7 @@ int selinux_disable(void)
>         printk(KERN_INFO "SELinux:  Disabled at runtime.\n");
>
>         selinux_disabled = 1;
> +       selinux_enabled = 0;
>
>         /* Reset security_ops to the secondary module, dummy or capability. */
>         security_ops = secondary_ops;
> diff -X /home/sds/dontdiff -rup linux-2.6.17-rc3-mm1/security/selinux/include/security.h linux-2.6.17-rc3-mm1-x2/security/selinux/include/security.h
> --- linux-2.6.17-rc3-mm1/security/selinux/include/security.h    2006-03-20 00:53:29.000000000 -0500
> +++ linux-2.6.17-rc3-mm1-x2/security/selinux/include/security.h 2006-05-03 10:25:39.000000000 -0400
> @@ -29,12 +29,7 @@
>  #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
>  #define POLICYDB_VERSION_MAX   POLICYDB_VERSION_AVTAB
>
> -#ifdef CONFIG_SECURITY_SELINUX_BOOTPARAM
>  extern int selinux_enabled;
> -#else
> -#define selinux_enabled 1
> -#endif
> -
>  extern int selinux_mls_enabled;
>
>  int security_load_policy(void * data, size_t len);
>
>
> --
> Stephen Smalley
> National Security Agency
>
>

--
Jon Smirl
jonsmirl@gmail.com
