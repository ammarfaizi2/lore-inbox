Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261707AbULBRms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbULBRms (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 12:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbULBRmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 12:42:45 -0500
Received: from pop.gmx.de ([213.165.64.20]:8141 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261708AbULBRmD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 12:42:03 -0500
X-Authenticated: #4399952
Date: Thu, 2 Dec 2004 18:44:21 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-19
Message-ID: <20041202184421.229cf5d5@mango.fruits.de>
In-Reply-To: <20041202134934.GA32216@elte.hu>
References: <20041201213023.GA23470@elte.hu>
	<32788.192.168.1.8.1101938057.squirrel@192.168.1.8>
	<20041201220916.GA24992@elte.hu>
	<20041201234355.0dac74cf@mango.fruits.de>
	<20041202084040.GC7585@elte.hu>
	<20041202132218.02ea2c48@mango.fruits.de>
	<20041202122931.GA25357@elte.hu>
	<20041202140612.4c07bca8@mango.fruits.de>
	<20041202131002.GA30503@elte.hu>
	<20041202144037.5c9da188@mango.fruits.de>
	<20041202134934.GA32216@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Thu__2_Dec_2004_18_44_21_+0100_1fv.skIxztpDm737"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Thu__2_Dec_2004_18_44_21_+0100_1fv.skIxztpDm737
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Dec 2004 14:49:34 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Florian Schmidt <mista.tapas@gmx.net> wrote:
> 
> > Ok, so if i want to find out whether a client violates the RT
> > constraints for its process callback i would have to add a call to
> > gettimeofday(1,1) at the start of the process callback and
> > gettimeofday(1,0) at the end.
> > 
> > Everything which causes a reschedule inbetween will then cause SIGUSR2
> > to be sent to the client for which i could either add a signal handler
> > in the client or just use gdb to get notified of it. 
> 
> correct. I'd expect there to be a number of less critical reschedules
> happening around startup/shutdown of a client, which one could consider
> a false positive, but there should be no unexpected rescheduling while
> the client is up and running.

Ok,

this simple patch adds the gettimeofday calls around the calling of the
process callback:

--- libjack/client.c.orig	2004-12-02 17:55:04.000000000 +0100
+++ libjack/client.c	2004-12-02 17:56:23.000000000 +0100
@@ -1238,6 +1238,9 @@
 			if (control->sync_cb)
 				jack_call_sync_client (client);
 
+			// enable atomicity check for RP kernels
+			gettimeofday(1,1);
+			
 			if (control->process) {
 				if (control->process (control->nframes,
 						      control->process_arg)
@@ -1247,7 +1250,10 @@
 			} else {
 				control->state = Finished;
 			}
-
+			
+			// disable atomicity check
+			gettimeofday(0,1);
+			
 			if (control->timebase_cb)
 				jack_call_timebase_master (client);
 

The results i see are rather interesting though. Even with a noop jack
client (which does nothing but return 0 in the process callback) i get a
syslog report everytime i start the client. Client source attached.

Dec  2 18:39:06 mango kernel: jack_test:22743 userspace BUG: scheduling in user-atomic context!
Dec  2 18:39:06 mango kernel:  [<c02a38b6>] schedule+0x76/0x130 (8)
Dec  2 18:39:06 mango kernel:  [<c02a44c5>] schedule_timeout+0x85/0xe0 (36)
Dec  2 18:39:06 mango kernel:  [<c016677f>] do_pollfd+0x4f/0x90 (48)
Dec  2 18:39:06 mango kernel:  [<c011ceb0>] process_timeout+0x0/0x10 (8)
Dec  2 18:39:06 mango kernel:  [<c016686a>] do_poll+0xaa/0xd0 (20)
Dec  2 18:39:06 mango kernel:  [<c01669e2>] sys_poll+0x152/0x230 (48)
Dec  2 18:39:06 mango kernel:  [<c0165db0>] __pollwait+0x0/0xd0 (36)
Dec  2 18:39:06 mango kernel:  [<c01025cb>] syscall_call+0x7/0xb (32)


The atomicity check operates on a per task (thread) basis right?

Flo

--Multipart=_Thu__2_Dec_2004_18_44_21_+0100_1fv.skIxztpDm737
Content-Type: text/x-c++src;
 name="jack_test.cc"
Content-Disposition: attachment;
 filename="jack_test.cc"
Content-Transfer-Encoding: 7bit

#include <jack/jack.h>
#include <iostream>
#include <sstream>
#include <unistd.h>

jack_client_t *client;
jack_port_t *iport;
jack_port_t *oport;

int wasted_loops = 0;

int sleep_seconds = 1;
int sleep_in_period = 2000;
int counter = 0;

int process(jack_nframes_t frames, void *arg) {
	/*
	// std::cout << "process callback" << std::endl;
	jack_default_audio_sample_t *ibuf;
	ibuf = (jack_default_audio_sample_t*)jack_port_get_buffer(iport, frames);

	jack_default_audio_sample_t *obuf;
	obuf = (jack_default_audio_sample_t*)jack_port_get_buffer(oport, frames);

	for (jack_nframes_t frame = 0; frame < frames; frame++) {
		for (int i = 0; i < wasted_loops; ++i) {
			// do nothing
		}
		obuf[frame] = ibuf[frame];
	}
	counter++;
	if (counter == sleep_in_period) {
	  //sleep(sleep_seconds);
	}
*/
        return 0;
}

int main(int argc, char *argv[]) {
	// default = 60 seconds
	unsigned int seconds_to_run = 60;
	if (argc > 1) {
		std::stringstream sec_stream;
		sec_stream << argv[1];
		sec_stream >> seconds_to_run;
		if (argc > 2) {
			std::stringstream waste_stream;
			waste_stream << argv[2];
			waste_stream >> wasted_loops;
			std::cout << "wasted loops: " << wasted_loops << std::endl;
		}
	}
	std::cout << "seconds to run: " << seconds_to_run << std::endl;
	
	std::stringstream pid_stream;
	pid_stream << getpid();
	
        std::cout << "client_new" << std::endl;
        client = jack_client_new(pid_stream.str().c_str());

        std::cout << "port_register." << std::endl;
        iport = jack_port_register(client, "in", JACK_DEFAULT_AUDIO_TYPE, JackPortIsInput|JackPortIsTerminal, 0);
	oport = jack_port_register(client, "out", JACK_DEFAULT_AUDIO_TYPE, JackPortIsTerminal|JackPortIsOutput, 0);

        std::cout << "set_process_callback" << std::endl;
        jack_set_process_callback(client, process, 0);

        std::cout << "activate" << std::endl;
        jack_activate(client);

        std::cout << "running" << std::endl;

        // while(1) {sleep(1);};
	sleep(seconds_to_run);

	jack_deactivate(client);
	jack_client_close(client);
}

--Multipart=_Thu__2_Dec_2004_18_44_21_+0100_1fv.skIxztpDm737--
