Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270441AbTHLOs5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 10:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270443AbTHLOs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 10:48:57 -0400
Received: from rzaixsrv2.rrz.uni-hamburg.de ([134.100.32.71]:30713 "EHLO
	rzaixsrv2.rrz.uni-hamburg.de") by vger.kernel.org with ESMTP
	id S270441AbTHLOsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 10:48:40 -0400
Message-ID: <1060699703.3f38fe37b8a1f@rzaixsrv6.rrz.uni-hamburg.de>
Date: Tue, 12 Aug 2003 16:48:23 +0200
From: in7y118@public.uni-hamburg.de
To: linux-kernel@vger.kernel.org
Cc: rhythmbox-devel@gnome.org, gstreamer-devel@lists.sourceforge.net
Subject: Linux 2.6 doesn't like Rhythmbox
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi people,

I'm running Linux 2.6.0-test2 now and found our "itunes clone" Rhythmbox (see 
http://rhythmbox.org) to have choppy playback. Simpler command-line players 
like madplay did not have this problem. (The heavily threaded gst-player had 
this problem, however.) I don't remember having choppy playback with Linux 
2.4.21-preempt either.

Reproducing this is simple if you run Gnome 2 and the snail-fast gnome-terminal:
Get Rhythmbox (I used the 0.4.99.2 prerelease from the website), play some 
sound with it and get your CPU to 100% with a fairly high-prio app (I like to 
switch tabs in gnome-terminal). Sound then starts having hickups.

More or less by accident I was looking at the output of top and found out that 
the audio playback thread had a worse priority than normal (top reported 
between 20 and 25). I then reniced the playback thread to -10 upon thread 
creation and was given problemless playback (top still reported the priority 
going up to 15 again).

Let me explain how threads in Rhythmbox work: The main thread is used for the 
GUI, other threads (mostly idle) take care of the library - reading out 
artist/title/... tags and monitoring file changes so the playlists gets updated 
automagically - and then there is a playback thread. This thread is spawned 
when playback of a file starts (a new one for each file). It starts by 
inspecting the file and constructing a pipeline depending on the file type (ogg 
decoder vs mp3 decoder vs ...). This takes half a second, maybe less. After 
that it proceeds to do read - decode - output to soundcard looping until the 
song is done playing.
The priority according to top starts becoming worse from the beginning of 
playback and gets worse during playback.


My question now is simple: Who shall I blame for this?


Cheers,

Benjamin
