Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261793AbVGPU2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbVGPU2s (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 16:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbVGPU2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 16:28:48 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:47783 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261809AbVGPU2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 16:28:37 -0400
Subject: Re: [ANNOUNCE] Interbench v0.20 - Interactivity benchmark
From: Lee Revell <rlrevell@joe-job.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: szonyi calin <caszonyi@yahoo.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck list <ck@vds.kolivas.org>, caszonyi@rdslink.ro
In-Reply-To: <200507140958.00510.kernel@kolivas.org>
References: <20050713112710.60204.qmail@web52902.mail.yahoo.com>
	 <1121276077.4435.50.camel@mindpipe> <200507140958.00510.kernel@kolivas.org>
Content-Type: text/plain
Date: Sat, 16 Jul 2005 16:28:35 -0400
Message-Id: <1121545716.10774.16.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-14 at 09:57 +1000, Con Kolivas wrote:
> On Thu, 14 Jul 2005 03:34, Lee Revell wrote:
> > On Wed, 2005-07-13 at 13:27 +0200, szonyi calin wrote:
> > > I have the following problem with audio:
> > > Xmms is running with threads for audio and spectrum
> > > analyzer(OpenGL).
> > > The audio eats 5% cpu, the spectrum analyzer about 80 %. The
> > > problem is that sometimes the spectrum analyzer is eating all of
> > > the cpu while the audio is skipping. Xmms is version 1.2.10
> > > kernel is vanilla, latest "stable" version 2.6.12, suid root.
> > >
> > > Does your benchmark simultes this kind of behaviour ?
> >
> > That's just a broken app, the kernel can't do anything about it.  XMMS
> > should not be running the spectrum analyzer thread at such a high
> > priority as to interfere with the audio thread.
> 
> I agree; optimising for this is just silly.

I took a closer look and it's indeed quite broken.  If XMMS is run in
realtime mode, and multithreading is enabled, it runs everything
SCHED_RR - GUI, audio, spectrum analyzer.  (And since it relies on new
threads inheriting RT scheduling when pthread_create()'d, the threads
will fail to get SCHED_RR on buggy NPTL versions like the one in Debian
Sarge).

This untested patch should enable RT scheduling for only the (ALSA)
audio thread.  Make sure NOT to run in realtime mode.

Lee

--- ../xmms-1.2.10+cvs20050209.orig/Output/alsa/audio.c	2005-01-31 17:45:08.000000000 -0500
+++ Output/alsa/audio.c	2005-07-16 16:06:06.000000000 -0400
@@ -962,6 +962,7 @@
 /* open callback */
 int alsa_open(AFormat fmt, int rate, int nch)
 {
+	struct sched_param sparam;
 	debug("Opening device");
 	inputf = snd_format_from_xmms(fmt, rate, nch);
 	effectf = snd_format_from_xmms(fmt, rate, nch);
@@ -1010,6 +1011,9 @@
 		flush_request = -1;
 
 		pthread_create(&audio_thread, NULL, alsa_loop, NULL);
+		sparam.sched_priority = sched_get_priority_max(SCHED_FIFO);
+		if (pthread_setschedparam (audio_thread, SCHED_FIFO, &sparam) )
+			fprintf(stderr, "Error %s getting SCHED_FIFO for audio thread\n", strerror (errno));
 	}
 
 	return 1;


