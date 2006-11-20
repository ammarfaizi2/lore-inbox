Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934060AbWKTLpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934060AbWKTLpO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 06:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934061AbWKTLpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 06:45:13 -0500
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:50077 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S934060AbWKTLpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 06:45:12 -0500
Message-ID: <45619547.5070301@s5r6.in-berlin.de>
Date: Mon, 20 Nov 2006 12:45:11 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.8) Gecko/20061030 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Patrick Caulfield <pcaulfie@redhat.com>, Adrian Bunk <bunk@stusta.de>
CC: cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
       David Teigland <teigland@redhat.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6.19-rc5-mm2] fs/dlm: fix recursive dependency in Kconfig
References: <tkrat.c2d67cf7278af0e7@s5r6.in-berlin.de> <456179F6.1060501@redhat.com>
In-Reply-To: <456179F6.1060501@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Caulfield wrote:
> The problem I found when using DEPENDS rather than SELECT in that
> position is that if you don't already have LINET or SCTP selected
> then neither of the transports appear and you can effectively
> select the DLM without any transports. and that won't compile.

That's why I added "depend on ... (INET || IP_SCTP)" at config DLM
itself. This problem does not exist with my patch AFAICS.

> I prefer the already posted solutions to this.

OK, I admit I didn't bother to look up if there were already other
approaches. I see that Adrian for example suggested "depend on ... INET"
even further up at the whole DLM menu.

There is one thing though which I have a slightly different opinion on
than that expressed by Adrian's patch
(http://lkml.org/lkml/2006/11/14/174): A subsystem outside of networking
shouldn't take specially into account that IP_SCTP itself depends in
INET --- even though it seems rather unlikely that CONFIG_IP_SCTP would
ever become independent of CONFIG_INET. I also don't agree with what
Adrian said in http://lkml.org/lkml/2006/11/15/85: The problem is not
really that option A selects option B but is missing a copy of B's
dependencies among its own dependencies, but rather that the .config
generator missed that "select" implies "depends on". "select" ==
"depends on, and switches magically on, so that the user doesn't have to
jump around in menues". This implies that .config generators should
switch on all dependencies of B if A selects B. If a generator is to
simplistic to support this, it should simply treat "select" exactly like
"depends on" in order to guarantee a correct .config.

Anyway. Whatever you chose to do (or already have chosen to do) in
fs/dlm/Kconfig, keep in mind that the "select" keyword is presently only
poorly supported by the various .config generators and that it forces UI
considerations into the Kconfig files which should better not be
overloaded with UI issues. Or in other words: It is rather easy to write
correct and well-supported Kconfig files if you stick with "depend on",
but you get into trouble fast with generous usage of "select".
-- 
Stefan Richter
-=====-=-==- =-== =-=--
http://arcgraph.de/sr/
