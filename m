Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262087AbUKVN05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262087AbUKVN05 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 08:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262094AbUKVN05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 08:26:57 -0500
Received: from pop.gmx.de ([213.165.64.20]:39585 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262087AbUKVN0v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 08:26:51 -0500
X-Authenticated: #4399952
Date: Mon, 22 Nov 2004 14:27:44 +0100
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
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.30-2
Message-ID: <20041122142744.0a29aceb@mango.fruits.de>
In-Reply-To: <20041122132459.GB19577@elte.hu>
References: <20041116125402.GA9258@elte.hu>
	<20041116130946.GA11053@elte.hu>
	<20041116134027.GA13360@elte.hu>
	<20041117124234.GA25956@elte.hu>
	<20041118123521.GA29091@elte.hu>
	<20041118164612.GA17040@elte.hu>
	<20041122005411.GA19363@elte.hu>
	<20041122020741.5d69f8bf@mango.fruits.de>
	<20041122094602.GA6817@elte.hu>
	<56781.195.245.190.93.1101119801.squirrel@195.245.190.93>
	<20041122132459.GB19577@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Mon__22_Nov_2004_14_27_44_+0100_I4MuhMtZzIVvZ2_E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Mon__22_Nov_2004_14_27_44_+0100_I4MuhMtZzIVvZ2_E
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Nov 2004 14:24:59 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> > Just made some test-runs with RT-V0.7.30-2, with my jackd-R +
> > 8*fluidsynth benchmark on my laptop (P4/UP), and the results don't
> > seem to be eligible to the hall of fame, at least when compared with
> > RT-0.7.7 as the ones I last posted here a few weeks ago.
> > 
> > I hate to say this, but the XRUN rate has increased since RT-0.7.7,
> > and the maximum scheduling delay reported by jackd has also degraded
> > to 1000 usecs (was around 600 usecs).
> 
> well, life would be too easy if two bugs were fixed at once ;) 

Hi,

i just wanted to mention that a good share of jack clients have issues themself, doing all kinds of funky stuff in the RT thread which they shouldn't do. Maybe the RP kernel just exposes this misuse in a greater visible way. I don't know if fluidsynth is one of them. We could only find out by code inspection. 

Another way to test a more complex scenario than just jackd running with an empty graph (assuming that jackd itself isn't to blame) while avoiding the risk of getting bad data due to insane clients would be to code up an example jackd client that does nothing but putting some load onto the jackd graph but in a strictly RT fashion (no blocking stuff whatsoever).

Attached you probably find the most minimal jack client thinkable that does nothing but copy data from its input to its output port. Its only parameter is the time in seconds it will run (default 60). The jack client name is determined by the PID, so it can be started multiple times (jackd requires a unique name for each client).

compile with

g++ -o jack_test jack_test.cc -ljack

This code can easily be adapted to produce more load (just do some math stuff with the data in the process callback).

It seems jackd has a limitation to 14 clients atm (don't ask me why). The 15th kills jackd ;)

Also i wanted to mention that a good share of ALSA drivers have issues, too, and aren't nessecarily suited to low latency audio work. I don't know how to rule these out except for using the ALSA dummy soundcard driver (which might have its own issues, but it's probably simple enough to work reliable. it just doesn't use any hw IRQ's so it's maybe not a good measure for what we want to test) or to use a soundcard with a proven good driver. 

flo

--Multipart=_Mon__22_Nov_2004_14_27_44_+0100_I4MuhMtZzIVvZ2_E
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

int process(jack_nframes_t frames, void *arg) {
	// std::cout << "process callback" << std::endl;
	jack_default_audio_sample_t *ibuf;
	ibuf = (jack_default_audio_sample_t*)jack_port_get_buffer(iport, frames);

	jack_default_audio_sample_t *obuf;
	obuf = (jack_default_audio_sample_t*)jack_port_get_buffer(oport, frames);

	for (jack_nframes_t frame = 0; frame < frames; frame++) {
		obuf[frame] = ibuf[frame];
	}
        return 1;
}

int main(int argc, char *argv[]) {
	// default = 60 seconds
	unsigned int seconds_to_run = 60;
	if (argc > 1) {
		std::stringstream sec_stream;
		sec_stream << argv[1];
		sec_stream >> seconds_to_run;
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

--Multipart=_Mon__22_Nov_2004_14_27_44_+0100_I4MuhMtZzIVvZ2_E--
