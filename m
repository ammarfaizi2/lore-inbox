Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132508AbRDQBkz>; Mon, 16 Apr 2001 21:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132511AbRDQBkp>; Mon, 16 Apr 2001 21:40:45 -0400
Received: from coruscant.franken.de ([193.174.159.226]:60679 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S132503AbRDQBkg>; Mon, 16 Apr 2001 21:40:36 -0400
Date: Mon, 16 Apr 2001 22:31:59 -0300
From: Harald Welte <laforge@gnumonks.org>
To: "Eric S. Raymond" <esr@thyrsus.com>, jeff millar <jeff@wa1hco.mv.com>,
        linux-kernel@vger.kernel.org
Subject: Re: comments on CML 1.1.0
Message-ID: <20010416223159.M16697@corellia.laforge.distro.conectiva>
In-Reply-To: <200104140317.f3E3Hv805992@snark.thyrsus.com> <20010414150421.A28066@l-t.ee> <002601c0c4fb$c7e54260$0201a8c0@home> <20010414155153.A12421@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
In-Reply-To: <20010414155153.A12421@thyrsus.com>; from esr@thyrsus.com on Sat, Apr 14, 2001 at 03:51:53PM -0400
X-Operating-System: Linux corellia.laforge.distro.conectiva 2.4.3
X-Date: Today is Sweetmorn, the 33rd day of Discord in the YOLD 3167
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 14, 2001 at 03:51:53PM -0400, Eric S. Raymond wrote:
> jeff millar <jeff@wa1hco.mv.com>:
> > Selecting IP_NF_COMPAT_IPCHAINS turns off IP_NF_CONNTRACK and friends.  But,
> > I think CML1, allowed both support to the new iptables and compatibility
> > modes to allow old ipchains scripts to work with the new kernel.
> 
> Would somebody who knows what these dependencies are please send me a rule
> patch?

Ok, as I am one of the netfilter people, and I've already cleaned up this 
issue after Linus' switch to the 'new-style' Makefiles somewhen in 2.4.0-textXX
I might be suitable for this job. 

Unfortunately I don't know too much about CML2, so I cannot provide you with
a straightforward ruleset, only with a description:

Basically there are the following dependencies:

1. you compile connection tracking as module
	a) iptables compiled as module
		- you can compile ANY or BOTH of ipchains, ipfwadm as 
		  module ONLY (not static)
	b) iptables compiled static
		- NO possibility of compiling ipchains or ipfwadm at all,
		  either as module or static
	c) iptables NOT compiled at all
		- you can compile ONE OF ipchains, ipfwadm statically
		- you can compile BOTH of them as modules

2. you compile connection tracking statically into the kernel
	- NO possibility of compiling ipchains or ipfwadm at all,
	  either module or static
	- iptables can be compiled modular or static


there's another interesting dependency, I'll describe the problem first:

Netfilter has modules called connection tracking and nat helpers. For
most protocols, they will appear in pairs (as opposed to only one module
called ip_masq_XXX in 2.2.x). They are performing independent functionality,
and you will never need the NAT helper on a non-nat box.

1. connection tracking (CONFIG_IP_NF_CONNTRACK) is on (M or Y)
   Full NAT (CONFIG_IP_NF_NAT) off
	- if CONFIG_IP_NF_FTP is OFF, none of ip_conntrack_ftp.c/ip_nat_ftp.c
	  are compiled
	- if CONFIG_IP_NF_FTP is ON (M or Y), ip_conntrcak_ftp.c is compiled
	  (as module or statically, as apropriate)
2. connection tracking is on (M or Y), Full NAT is on (M or Y)
	- if CONFIG_IP_NF_FTP is OFF, none of ip_conntrack_ftp.c/ip_nat_ftp.c
	  are compiled
	- if CONFIG_IP_NF_FTP is ON (M or Y), both ip_conntrack_ftp.c AND
	  ip_nat_ftp.c are compiled (module or static, as user wishes)


I'm asking myself if we now should be proud of having the most complicated
dependencies of the whole kernel ;)

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org                http://www.gnumonks.org
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M- 
V-- PS+ PE-- Y+ PGP++ t++ 5-- !X !R tv-- b+++ DI? !D G+ e* h+ r% y+(*)
