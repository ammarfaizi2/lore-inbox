Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262318AbRERNyz>; Fri, 18 May 2001 09:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262322AbRERNyq>; Fri, 18 May 2001 09:54:46 -0400
Received: from chaos.analogic.com ([204.178.40.224]:5504 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S262318AbRERNyi>; Fri, 18 May 2001 09:54:38 -0400
Date: Fri, 18 May 2001 09:54:33 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: sebastien person <sebastien.person@sycomore.fr>
cc: Bart Trojanowski <bart@jukie.net>,
        liste noyau linux <linux-kernel@vger.kernel.org>
Subject: Re: [newbie] timer in module
In-Reply-To: <20010518153347.188888ba.sebastien.person@sycomore.fr>
Message-ID: <Pine.LNX.3.95.1010518093918.1698A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 May 2001, sebastien person wrote:

> Le Fri, 18 May 2001 08:32:33 -0400 (EDT)
> Bart Trojanowski <bart@jukie.net> a ecrit :
> 
> > On Fri, 18 May 2001, sebastien person wrote:
> > 
> > > I have a network module that need to regularly get data from network
> > > adaptater.
> > > But I don't know if it safe to do a loop with a timer in the module.
> > 
> > First off you have to decide where you want to run your 'get data'. 
> There
> > are three context you can pick from: user priority or from the kernel. 
> If
> > you run the loop below from a user context then you will have a very
> > unresponsive system but at least other things will still run.  If you
> run
> > that from a kernel context nothing else will run... unless you
> explicitly
> > call the scheduler.
> 
> So the fact to call the scheduler allow me to handle send request for
> example ?
> 
> > 
> > > My aim is to do a get data call every x seconds (x is variable).
> > 
> > You mentioned a timer... it runs in kernel context but at least it
> > will not end up hanging your system up.  This is how you would use one:
> > 
> > struct tq_struct timer;
> > init_timer(&timer);
> > timer.routine = func;
> > timer.data = something;
> > mod_timer(&timer, 5*HZ); // 5 seconds from now
> > 
> > void func( unsigned long something ) {
> > 	get_data( something );
> > 	mod_timer(&timer, 5*HZ); // again in 5 seconds
> > }
> > 
> > Make sure you call 'del_timer_sync' once you are done.
> > 
> > > Is it better to let an external program executing timer call and get
> data
> > > call via ioctl ?
> > 
> > Since you are getting data every 5 seconds you may as well use a user
> > space program.  It does not seem like you are looking for phenomenal
> > responsiveness here.
> > 
> > Bart.
> > 
> > -- 
> > 	WebSig: http://www.jukie.net/~bart/sig/
> 
> Thanks for all these details
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Errm... Something that happens every 5 seconds??? USER MODE. This
Is what Unix/Linux is very good at!

Generic device:

    fd = open("/dev/device", O_RDWR);
    for(;;)
    {
        read(fd, buf, sizeof(buf));
        ioctl(fd, GET_MY_PARMS, &params);
        sleep(5);
    }

Network modules use sockets.

   struct ifreq iq;
   memset(&iq, 0x00, sizeof(iq));
   strcpy(iq.ifr_name. "eth0");
   iq.ifr_data = pointer_to_a_place_to_put_get_stuff;
   s = socket(AF_INET, SOCK_DGRAM, 0);
   for(;;)
   {  
       ioctl(s, GET_MY_PARAMS, &iq);
       sleep(5);
    }

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


