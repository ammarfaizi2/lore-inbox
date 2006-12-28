Return-Path: <linux-kernel-owner+w=401wt.eu-S964928AbWL1Fde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928AbWL1Fde (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 00:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbWL1Fde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 00:33:34 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:48086
	"EHLO grelber.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964928AbWL1Fdd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 00:33:33 -0500
From: Rob Landley <rob@landley.net>
To: Denis Vlasenko <vda.linux@googlemail.com>
Subject: Re: Feature request: exec self for NOMMU.
Date: Thu, 28 Dec 2006 00:32:25 -0500
User-Agent: KMail/1.9.1
Cc: ray-gmail@madrabbit.org, linux-kernel@vger.kernel.org,
       "David McCullough" <david_mccullough@au.securecomputing.com>
References: <200612261823.07927.rob@landley.net> <200612271603.39454.rob@landley.net> <200612280348.16670.vda.linux@googlemail.com>
In-Reply-To: <200612280348.16670.vda.linux@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612280032.26101.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 December 2006 9:48 pm, Denis Vlasenko wrote:
> Yes Rob, I know it can be done like this. But we don't want this.
> In the tar example, we want :
> 
> 'Run my own binary again, with parameters: "zcat" "a.tar.gz",
> even if there is no [/usr][/local]/bin/zcat -> busybox link anywhere'
> 
> We do not want to _search for_ zcat. We want to reexec our own binary.

If we find our own binary, we can reexec it.  What we search for isn't zcat, 
it's argv[0], and the search needs to be done in main() before any logic that 
can chdir or set $PATH gets called.  Then save that path until we need it.

The kernel does not currently provide an easy way to do exec ourselves, but we 
can do it ourself.  (And this is a way to do it _without_ proc.)

The problem is, there's no guarante that argv[0] is actually the first 
argument to exec(), it can be any arbitrary string.  (In fact, if tar wants 
to re-exec itself as zcat, we can take advantage of this with 
execv("/blah/tar", ["zcat", "-"]);)  So it's still a hack.  It should work if 
we're called from a shell, but not necessarily from elsewhere.

*shrug*  Kernel support for re-execing ourself would be nice, especially in 
combination with vfork().  If not, I'll figure something out and make it work 
in toybox.  There are a half-dozen non-kernel approaches, all varying degrees 
of hackish.  (And daemonize() can probably be done with clone().)

Rob
-- 
"Perfection is reached, not when there is no longer anything to add, but
when there is no longer anything to take away." - Antoine de Saint-Exupery
