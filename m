Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752318AbWCFJKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752318AbWCFJKp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 04:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752315AbWCFJKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 04:10:45 -0500
Received: from mx1.redhat.com ([66.187.233.31]:47744 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752318AbWCFJKn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 04:10:43 -0500
Date: Mon, 6 Mar 2006 04:10:32 -0500
From: Dave Jones <davej@redhat.com>
To: tiwai@suse.de
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: opl3_oss use after free.
Message-ID: <20060306091032.GA21851@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, tiwai@suse.de,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060306090533.GA12999@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060306090533.GA12999@redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 04:05:33AM -0500, Dave Jones wrote:
 > Don't read from free'd memory.  Also make use of the return
 > value, and don't register the device if something went wrong
 > creating the port.
 > 
 > Coverity #955

identical bug in opl3_seq.c
This needs to check the return too, but I got lazy and just
fixed the use-after-free.

Coverity #954

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6/sound/drivers/opl3/opl3_seq.c~	2006-03-06 04:07:42.000000000 -0500
+++ linux-2.6/sound/drivers/opl3/opl3_seq.c	2006-03-06 04:08:36.000000000 -0500
@@ -207,8 +207,10 @@ static int snd_opl3_synth_create_port(st
 						      16, voices,
 						      name);
 	if (opl3->chset->port < 0) {
+		int port;
+		port = opl3->chset->port;
 		snd_midi_channel_free_set(opl3->chset);
-		return opl3->chset->port;
+		return port;
 	}
 	return 0;
 }

-- 
http://www.codemonkey.org.uk
