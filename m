Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267601AbUHPM5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267601AbUHPM5q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 08:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267599AbUHPM5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 08:57:46 -0400
Received: from mail.gmx.de ([213.165.64.20]:62097 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267601AbUHPM5V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 08:57:21 -0400
X-Authenticated: #4399952
Date: Mon, 16 Aug 2004 15:07:51 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P1
Message-Id: <20040816150751.5ac166b3@mango.fruits.de>
In-Reply-To: <1092655029.13981.24.camel@krustophenia.net>
References: <20040815115649.GA26259@elte.hu>
	<20040816022554.16c3c84a@mango.fruits.de>
	<1092622121.867.109.camel@krustophenia.net>
	<20040816023655.GA8746@elte.hu>
	<1092624221.867.118.camel@krustophenia.net>
	<20040816032806.GA11750@elte.hu>
	<20040816033623.GA12157@elte.hu>
	<1092627691.867.150.camel@krustophenia.net>
	<20040816034618.GA13063@elte.hu>
	<1092628493.810.3.camel@krustophenia.net>
	<20040816040515.GA13665@elte.hu>
	<20040816131359.1107bd69@mango.fruits.de>
	<1092655029.13981.24.camel@krustophenia.net>
X-Mailer: Sylpheed-Claws 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Mon__16_Aug_2004_15_07_51_+0200_IdYRRuFvRbYLFEzd"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Mon__16_Aug_2004_15_07_51_+0200_IdYRRuFvRbYLFEzd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Aug 2004 07:17:10 -0400
Lee Revell <rlrevell@joe-job.com> wrote:

> > But it seems that this wasn't the only thing causing an xrun on
> > jackd client startup. I will try to take another look at the jackd
> > source..
> > 
> 
> Ingo mentioned that possibly the mlockall issue resulted from both
> processes mapping some of the same pages, which was ruled out by using
> small test programs, but maybe that is what is going on here.  A jack
> client and server by definition have to map some of the same pages.
> 
> Would it be worthwhile to compile the jack client -static?

Here's a minimal jack client which does _not_ produce an xrun on startup
for me (it doesn't really do anything either).. Maybe the xruns are the
other clients fault and not really determined by the jack mechanisms.. I
will extend it step by step to do something functional.. maybe i'll find
out what change introduces xruns. compile with

g++ jack_test.cc `pkg-config jack --libs` -o jack_test


jack_test.cc:
----------------------
#include <jack/jack.h>
#include <iostream>

jack_client_t *client;
jack_port_t *port;

int process(jack_nframes_t frames, void *arg) {
        return 0;
}

int main(int argc, char *argv[]) {
        std::cout << "client_new" << std::endl;
        client = jack_client_new("foo");

        std::cout << "port_register." << std::endl;
        port = jack_port_register(client, "foobar",
JACK_DEFAULT_AUDIO_TYPE, JackPortIsOutput|JackPortIsTerminal, 0);

        std::cout << "set_process_callback" << std::endl;
        jack_set_process_callback(client, process, 0);

        std::cout << "activate" << std::endl;
        jack_activate(client);

        std::cout << "running" << std::endl;
        while(1) {sleep(1);};
}
-----------------------


-- 
Palimm Palimm!
http://affenbande.org/~tapas/


--Multipart=_Mon__16_Aug_2004_15_07_51_+0200_IdYRRuFvRbYLFEzd
Content-Type: text/x-c++src;
 name="jack_test.cc"
Content-Disposition: attachment;
 filename="jack_test.cc"
Content-Transfer-Encoding: 7bit

#include <jack/jack.h>
#include <iostream>

jack_client_t *client;
jack_port_t *port;

int process(jack_nframes_t frames, void *arg) {
        return 0;
}

int main(int argc, char *argv[]) {
        std::cout << "client_new" << std::endl;
        client = jack_client_new("foo");

        std::cout << "port_register." << std::endl;
        port = jack_port_register(client, "foobar", JACK_DEFAULT_AUDIO_TYPE, JackPortIsOutput|JackPortIsTerminal, 0);

        std::cout << "set_process_callback" << std::endl;
        jack_set_process_callback(client, process, 0);

        std::cout << "activate" << std::endl;
        jack_activate(client);

        std::cout << "running" << std::endl;
        while(1) {sleep(1);};
}

--Multipart=_Mon__16_Aug_2004_15_07_51_+0200_IdYRRuFvRbYLFEzd--
