Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751868AbWAOIgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbWAOIgP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 03:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751874AbWAOIgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 03:36:15 -0500
Received: from styx.suse.cz ([82.119.242.94]:11187 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1751868AbWAOIgO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 03:36:14 -0500
Message-ID: <43CA176A.7080903@seznam.cz>
Date: Sun, 15 Jan 2006 10:35:38 +0100
From: feyd <feyd@seznam.cz>
User-Agent: Thunderbird 1.5 (X11/20051027)
MIME-Version: 1.0
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: wireless: recap of current issues (configuration)
References: <20060113195723.GB16166@tuxdriver.com> <20060113212605.GD16166@tuxdriver.com> <20060113213011.GE16166@tuxdriver.com> <20060113221935.GJ16166@tuxdriver.com>
In-Reply-To: <20060113221935.GJ16166@tuxdriver.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John W. Linville wrote:
> Configuration seems to be coalescing around netlink.  Among other
> things, this technology provides for muliticast requests and
> asynchronous event notification.

On the other hand, the tree structure of sysfs can handle the
resource exclusivity and sharing naturaly.

A proposal of the layout:

template - template of device that can be created
profile  - exclusive set of templates and other resources

plain SoftMAC card:
/sys/class/ieee80211/phy0/profile0/template0/mode      # ap
                      |      |              /...       # ap specific stuff
                      |      |
                      |      *--->/template1/mode      # sta
                      |      |              /...       # sta specific stuff
                      |      |
                      |      *--->/template2/mode      # rfmon
                      |                     /...       # rfmon specific stuff
                      |
                      *->/profile
                         /channel
                         /txpower
                         /...                   # other phy specific stuff


FullMAC card with mode constraints:
/sys/class/ieee80211/phy0/profile0/template0/mode      # sta
                      |                     /...       # sta specific stuff
                      |
                      *->/profile1/template0/mode      # rfmon
                      |                     /...       # rfmon specific stuff
                      |
                      *->/...                   # phy specific stuff


virtual interface:
/sys/class/ieee80211/sta0/parent      # ->../phy0
                         /...


card with two chips that share some phy resources:
/sys/class/ieee80211/phy0/txpower     # shared txpower
                         /...

/sys/class/ieee80211/phy1/parent      # ->../phy0
                         /channel     # independent
                         /...

/sys/class/ieee80211/phy2/parent      # ->../phy0
                         /channel     # independent
                         /...

Feyd

