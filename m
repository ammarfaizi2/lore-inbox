Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261769AbULBVTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbULBVTV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 16:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbULBVLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 16:11:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:61418 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261769AbULBVIF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 16:08:05 -0500
X-Authenticated: #4399952
Date: Thu, 2 Dec 2004 22:10:26 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: "Jack O'Quin" <joq@io.com>, Andrew Burgess <aab@cichlid.com>,
       linux-kernel@vger.kernel.org, jackit-devel@lists.sourceforge.net
Subject: Re: [Jackit-devel] Re: Real-Time Preemption,
 -RT-2.6.10-rc2-mm3-V0.7.31-19
Message-ID: <20041202221026.016f8edf@mango.fruits.de>
In-Reply-To: <20041202210318.47c77872@mango.fruits.de>
References: <200412021546.iB2FkK5a005502@cichlid.com>
	<20041202170315.067d7853@mango.fruits.de>
	<87y8ggekds.fsf@sulphur.joq.us>
	<20041202175756.0e50f101@mango.fruits.de>
	<20041202180910.0d77cbbb@mango.fruits.de>
	<87d5xsehby.fsf@sulphur.joq.us>
	<20041202210318.47c77872@mango.fruits.de>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Thu__2_Dec_2004_22_10_26_+0100_ttCry=mLXRSJ45no"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Thu__2_Dec_2004_22_10_26_+0100_ttCry=mLXRSJ45no
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Dec 2004 21:03:18 +0100
Florian Schmidt <mista.tapas@gmx.net> wrote:

> On 02 Dec 2004 11:32:49 -0600
> "Jack O'Quin" <joq@io.com> wrote:
> 
> > Florian Schmidt <mista.tapas@gmx.net> writes:
> > 
> > > Hmm, i must have missed something in jackd's source. i thought
> > > control->process() directly calls the clients process callback..
> > 
> > It does.
> 
> Then either i have misunderstood how it works, or the mechanism is still
> buggy.. Wrote mail to Ingo. Will report to jackit-devel when i get an
> answer.

PEBCAK :) Here's the corrected patch:

--- libjack/client.c.orig	2004-12-02 17:55:04.000000000 +0100
+++ libjack/client.c	2004-12-02 22:04:06.000000000 +0100
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
+			gettimeofday(1,0);
+			
 			if (control->timebase_cb)
 				jack_call_timebase_master (client);
 

seems to work well with my changed jack_test client (this one sleeps in
the 1000th call of the process callback and thuis triggers this trace
and aborts as it doesn't handle SIGUSR2). test client attached.

Dec  2 22:05:10 mango kernel: jack_test:3043 userspace BUG: scheduling in user-atomic context!
Dec  2 22:05:10 mango kernel:  [<c02a38b6>] schedule+0x76/0x130 (8)
Dec  2 22:05:10 mango kernel:  [<c02a44c5>] schedule_timeout+0x85/0xe0 (36)
Dec  2 22:05:10 mango kernel:  [<c01e2f02>] copy_from_user+0x42/0x80 (48)
Dec  2 22:05:10 mango kernel:  [<c011ceb0>] process_timeout+0x0/0x10 (8)
Dec  2 22:05:10 mango kernel:  [<c011cfae>] sys_nanosleep+0xde/0x170 (20)
Dec  2 22:05:10 mango kernel:  [<c01025cb>] syscall_call+0x7/0xb (52)

flo

--Multipart=_Thu__2_Dec_2004_22_10_26_+0100_ttCry=mLXRSJ45no
Content-Type: text/x-c++src;
 name="jack_test.cc"
Content-Disposition: attachment;
 filename="jack_test.cc"
Content-Transfer-Encoding: 7bit

#include <jack/jack.h>
#include <iostream>
#include <sstream>
#include <unistd.h>
#include <signal.h>

jack_client_t *client;
jack_port_t *iport;
jack_port_t *oport;

int wasted_loops = 0;

int sleep_seconds = 1;
int sleep_in_period = 1000;
int counter = 0;

int process(jack_nframes_t frames, void *arg) {
	
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
	  sleep(sleep_seconds);
	}

        return 0;
}
void signalled(int sig) {
  std::cout << "signalled" << std::endl;
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

	// signal(SIGUSR2, signalled);

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

--Multipart=_Thu__2_Dec_2004_22_10_26_+0100_ttCry=mLXRSJ45no--
