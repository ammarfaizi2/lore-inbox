Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbUAEEwl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 23:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263510AbUAEEwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 23:52:41 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.135.30]:58383 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S262714AbUAEEwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 23:52:38 -0500
Date: Mon, 05 Jan 2004 13:52:52 +0900 (JST)
Message-Id: <20040105.135252.07995935.yoshfuji@linux-ipv6.org>
To: erik@hensema.net
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: (usagi-core 16947) Re: 2.6.0: something is leaking memory
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <slrnbvh1hd.jl6.erik@dexter.hensema.net>
References: <slrnbvgohn.1pb.erik@dexter.hensema.net>
	<Pine.LNX.4.58.0401041257290.2162@home.osdl.org>
	<slrnbvh1hd.jl6.erik@dexter.hensema.net>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <slrnbvh1hd.jl6.erik@dexter.hensema.net> (at Sun, 4 Jan 2004 21:31:26 +0000 (UTC)), Erik Hensema <erik@hensema.net> says:

> > Can you do /proc/slabinfo too?
> 
> Sure, this is of course my currently running system, 4 days, 9:53
> uptime.
> 
> slabinfo - version: 2.0
> # name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <batchcount> <limit> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
:
> tcp6_sock          19729  19732   1024    4    1 : tunables   54   27    0 : slabdata   4933   4933      0
:
> > Clearly the memory leak isn't in the page cache, so the most likely source 
> > is network buffers, and most likely in iptables connection tracking or 
> > similar. If you actually _use_ IPv6, then that is also more likely to have 
> > leaks just due to less testing.
> 
> I do use IPv6. I've got three active tunnels and native IPv6 over
> ethernet.
> 
> I've always had problems with nscd leaking filedescriptors, all
> IPv6 connections to my LDAP server. This started after upgrading
> suse 8.0 to 8.2 (I think the problem is in nss_ldap).
> I'm restarting nscd using a cronjob every night now. Output of
> netstat --inet6 -avpn is below. All sockets in CLOSE_WAIT are
> leaked and will go away after a nscd restart.

How about /proc/slabinfo just after restarting nss_ldap?

> The server isn't very critical, but I do need it. I'm willing to
> try some patches (or do an upgrade to -mm), but nothing to wild.
> 
> netstat --inet6 -avpn
> 
> Active Internet connections (servers and established)
> Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name   
> tcp        0      0 :::22                   :::*                    LISTEN      1208/sshd           
> tcp        0      0 :::119                  :::*                    LISTEN      1364/innd           
> tcp        0      0 :::25                   :::*                    LISTEN      1433/sendmail: acce 
> tcp        0      0 :::953                  :::*                    LISTEN      1175/named          
> tcp        0      0 ::1:6010                :::*                    LISTEN      19900/sshd          
> tcp        0      0 ::1:6011                :::*                    LISTEN      20150/sshd          
> tcp        1      0 ::1:50565               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
> tcp        1      0 ::1:50224               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
> tcp        0      0 2001:888:10a1::1:389    ::1:55936               ESTABLISHED 1145/slapd          
> tcp        1      0 ::1:50343               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
> tcp        1      0 ::1:50988               2001:888:10a1::1:389    CLOSE_WAIT  26536/nscd          
:

There're too many sockets in CLOSE_WAIT, but the number is very different from
"tcp6_sock."


And, what is happened when you use ipv4 in your nscd?

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
