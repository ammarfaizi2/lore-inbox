Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162554AbWLGRQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162554AbWLGRQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 12:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162553AbWLGRQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 12:16:26 -0500
Received: from kurby.webscope.com ([204.141.84.54]:55394 "EHLO
	kirby.webscope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162554AbWLGRQZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 12:16:25 -0500
Message-ID: <45784BD7.7010605@linuxtv.org>
Date: Thu, 07 Dec 2006 12:13:59 -0500
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: mchehab@infradead.org, v4l-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org
Subject: Re: [v4l-dvb-maintainer] [2.6 patch] cx88/saa7134: remove unused
 -DHAVE_VIDEO_BUF_DVB
References: <20061207150028.GJ8963@stusta.de> <457834E1.1090406@linuxtv.org> <20061207164245.GK8963@stusta.de>
In-Reply-To: <20061207164245.GK8963@stusta.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Thu, Dec 07, 2006 at 10:36:01AM -0500, Michael Krufky wrote:
>> Adrian Bunk wrote:
>>> This patch removes the unused HAVE_VIDEO_BUF_DVB define.

[snip]

>> ...We need this in order to allow compilation of the cx88 / saa7134 modules
>> without DVB support. (analog only)
>  
> Ah, you added them in v4l-dvb last year.

You are correct:  Tue Oct 11 20:11:34 2005 +0000 (14 months ago)

http://linuxtv.org/hg/v4l-dvb?cmd=changeset;node=56cf49b544f0

> But they are neither in Linus' tree nor in the v4l-dvb git tree that is 
> in the latest -mm.

hmm... looks like some changesets never made it over to git from our hg tree.

> Compilation of cx88 and saa7134 without DVB works fine in these trees, 
> so what's the story behind this?

It's a bug -- looks like CONFIG_VIDEO_BUF_DVB is being enabled, regardless
of whether or not it is selected -- otherwise we'd get other compiler errors,
because both cx88 and saa7134 have dependencies on video-buf-dvb.

VIDEO_BUF_DVB is being build without it's dependency, DVB_CORE -- that is
the only reason why the build is still working, but it sounds unstable to me.

CONFIG_VIDEO_BUF_DVB is set inside drivers/media/Kconfig, with zero
dependencies... In fact, VIDEO_BUF_DVB "depends on DVB_CORE" , but
this is not being reflected in Kconfig.

Hmm... looks like a bit of a mess.

The story is much clearer now... Looks like we should in fact apply your
patch, Adrian, but we will also have to make the following additional
changes:

- add "depends on DVB_CORE" to the Kconfig entry for VIDEO_BUF_DVB
- convert the #ifdef tests in the hg repository for HAVE_VIDEO_BUF_DVB
	to look for the CONFIG_VIDEO_BUF_DVB instead
- generate a patch against Linus' tree that add's these #ifdefs to the
	cx88 and saa7134 drivers.

If you dont mind, I'd like to take care of this stuff myself.  I will prepare
these patches tomorrow, and I'll have them applied to both our v4l-dvb.hg
repository on linuxtv.org, and I'll also ask Mauro to merge them into his git
tree before his next pull request to Linus.

Thanks, Adrian, for pointing out this inconsistency.


Cheers,

Michael Krufky

