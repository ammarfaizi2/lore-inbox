Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270700AbTHFKqQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 06:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270703AbTHFKqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 06:46:16 -0400
Received: from home.wiggy.net ([213.84.101.140]:23936 "EHLO
	thunder.home.wiggy.net") by vger.kernel.org with ESMTP
	id S270700AbTHFKqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 06:46:14 -0400
Date: Wed, 6 Aug 2003 12:46:13 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: linux-kernel@vger.kernel.org
Cc: nfs@lists.sourceforge.net
Subject: nfs/nfsd gets stuck on a write
Message-ID: <20030806104612.GB703@wiggy.net>
Mail-Followup-To: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I seem to have hit a nfs problem between two 2.6.0-test2 machines. 
Mounting works properly, but at some point when logging in with /home
over NFS things get stuck. A tcpdump reveals the following:

12:37:38.601967 192.168.1.50.3218252557 > 192.168.1.2.nfs: 132 getattr fh Unknown/1 (DF)
12:37:38.617871 192.168.1.2.nfs > 192.168.1.50.3218252557: reply ok 112 (DF)
12:37:38.618274 192.168.1.50.3235029773 > 192.168.1.2.nfs: 132 getattr fh Unknown/1 (DF)
12:37:38.627868 192.168.1.2.nfs > 192.168.1.50.3235029773: reply ok 112 (DF)
12:37:38.628238 192.168.1.50.3251806989 > 192.168.1.2.nfs: 132 getattr fh Unknown/1 (DF)
12:37:38.637865 192.168.1.2.nfs > 192.168.1.50.3251806989: reply ok 112 (DF)
12:37:38.638276 192.168.1.50.3268584205 > 192.168.1.2.nfs: 132 getattr fh Unknown/1 (DF)
12:37:38.646863 192.168.1.2.nfs > 192.168.1.50.3268584205: reply ok 112 (DF)
12:37:38.647348 192.168.1.50.3285361421 > 192.168.1.2.nfs: 132 getattr fh Unknown/1 (DF)
12:37:38.655862 192.168.1.2.nfs > 192.168.1.50.3285361421: reply ok 112 (DF)
12:37:38.656294 192.168.1.50.3302138637 > 192.168.1.2.nfs: 140 lookup fh Unknown/1 "backgrounds" (DF)
12:37:38.664860 192.168.1.2.nfs > 192.168.1.50.3302138637: reply ok 228 (DF)
12:37:38.665190 192.168.1.50.3318915853 > 192.168.1.2.nfs: 132 getattr fh Unknown/1 (DF)
12:37:38.685857 192.168.1.2.nfs > 192.168.1.50.3318915853: reply ok 112 (DF)
12:37:38.687035 192.168.1.50.3335693069 > 192.168.1.2.nfs: 1472 write fh Unknown/1 6189 bytes @ 0x000000000 (frag 41128:1480@0+)
12:37:38.687155 192.168.1.50 > 192.168.1.2: udp (frag 41128:1480@1480+)
12:37:38.687278 192.168.1.50 > 192.168.1.2: udp (frag 41128:1480@2960+)
12:37:38.687401 192.168.1.50 > 192.168.1.2: udp (frag 41128:1480@4440+)
12:37:38.687429 192.168.1.50 > 192.168.1.2: udp (frag 41128:432@5920)
12:37:39.044132 192.168.1.50.3335693069 > 192.168.1.2.nfs: 1472 write fh Unknown/1 6189 bytes @ 0x000000000 (frag 41129:1480@0+)
12:37:39.044250 192.168.1.50 > 192.168.1.2: udp (frag 41129:1480@1480+)
12:37:39.044371 192.168.1.50 > 192.168.1.2: udp (frag 41129:1480@2960+)
12:37:39.044496 192.168.1.50 > 192.168.1.2: udp (frag 41129:1480@4440+)
12:37:39.044523 192.168.1.50 > 192.168.1.2: udp (frag 41129:432@5920)
12:37:39.758006 192.168.1.50.3335693069 > 192.168.1.2.nfs: 1472 write fh Unknown/1 6189 bytes @ 0x000000000 (frag 41130:1480@0+)
12:37:39.758125 192.168.1.50 > 192.168.1.2: udp (frag 41130:1480@1480+)
12:37:39.758248 192.168.1.50 > 192.168.1.2: udp (frag 41130:1480@2960+)
12:37:39.758371 192.168.1.50 > 192.168.1.2: udp (frag 41130:1480@4440+)
12:37:39.758399 192.168.1.50 > 192.168.1.2: udp (frag 41130:432@5920)
12:37:41.185748 192.168.1.50.3335693069 > 192.168.1.2.nfs: 1472 write fh Unknown/1 6189 bytes @ 0x000000000 (frag 41131:1480@0+)
12:37:41.185866 192.168.1.50 > 192.168.1.2: udp (frag 41131:1480@1480+)
12:37:41.185988 192.168.1.50 > 192.168.1.2: udp (frag 41131:1480@2960+)
12:37:41.186110 192.168.1.50 > 192.168.1.2: udp (frag 41131:1480@4440+)
12:37:41.186138 192.168.1.50 > 192.168.1.2: udp (frag 41131:432@5920)

Since 192.168.1.2 does not respond 192.168.1.50 keeps sending that data
and basically gets stuck waiting for an answer. A complete tcpdump from
the booting of the client to it getting stuck can be found at
http://home.wiggy.net/lkml/nfs.tcpdump .

Both machines have a similar configuration: 2.6.0-test2 with NFS and NFS
over TCP enabled. There are no firewalls blocking traffic between those
two machines.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.

