Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750867AbVJVR0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbVJVR0r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 13:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbVJVR0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 13:26:47 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:55235 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750819AbVJVR0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 13:26:46 -0400
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: /etc/mtab and per-process namespaces
To: greg@enjellic.com, Mike Waychison <mikew@google.com>,
       Ram <linuxram@us.ibm.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       leimy2k@gmail.com
Reply-To: 7eggert@gmx.de
Date: Sat, 22 Oct 2005 19:26:16 +0200
References: <50rBX-76N-37@gated-at.bofh.it> <50rBX-76N-35@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1ETN8K-0001bd-NO@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dr. Greg Wettstein <greg@wind.enjellic.com> wrote:
> On Oct 13,  7:10pm, Mike Waychison wrote:
> } Subject: Re: /etc/mtab and per-process namespaces

> I've been pondering the best way to take on the mount problem.
> Current mount binaries seem to fall back to /proc/mounts if /etc/mtab
> is not present.  All bets are off of course if the mount binary is
> used for the bind mount since a new /etc/mtab is created.
> 
> I'm willing to whack on the mount binary a bit as part of this.  The
> obvious solution is to teach mount to act differently if it is running
> in a private namespace.  If anybody knows of a good way to detect this
> I would be interested in knowing that.  In newns (the namespace sudo
> tool) I'm setting an environment variable for mount to detect on but a
> system level approach would be more generic.

- If named namespaces are to be implemented, you could check for a set
  namespace ID. (You could also get rid of the persistent-namespace-daemon.)

- If secure user mounts are implemented, missing privileges will be hint.
  Privileged mounts will require a global configuration where a flag can
  be set. (BTW: You'll also want to disable user mounts in global namespaces
  to catch errors, abuse and exploits)

- Until any of these is implemented, users will run in a private namespace,
  so UID != EUID will indicate a private namespace. Unfortunately this is
  not secure, but:

- If the proc/mounts information is extended as described below, a different
  behaviour wouldn't make sense anymore, would it?

> The other problem is the information exported in /proc/mounts.  It
> would seem problematic to modify its format but in order to serve as a
> useful source of information for a modified mount binary it would need
> to contain mount option information.  Since this is definitely process
> specific information it would seem to call for something in /proc
> rather than /sysfs.  Do we need a new pseudo-file?

- The file format is broken for whitespace in filenames, so changing the
  format in these cases by adding quoting won't actually break anything.

- The userspace options (loop device etc) can be encoded in the mount
  options field, e.g.
  'rw,mount=lo:"/home/Arthur Dent/iso":/dev/loop/42;ns=public,async'.

So if you _want_ to keep the format, you can IMHO do so. Maybe you can
think of something better, who knows? We'll need to upgrade the tools
to use non-broken semantics anyway, so as long as you keep the old file
around, this should be no real problem.

-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
