Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271698AbRIJUre>; Mon, 10 Sep 2001 16:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271687AbRIJUrZ>; Mon, 10 Sep 2001 16:47:25 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:30732 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S271677AbRIJUrI>; Mon, 10 Sep 2001 16:47:08 -0400
Date: Mon, 10 Sep 2001 22:14:48 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: kuznet@ms2.inr.ac.ru
Cc: matthias.andree@gmx.de, alan@lxorguk.ukuu.org.uk, wietse@porcupine.org,
        linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
        netdev@oss.sgi.com
Subject: Re: [PATCH] ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19
Message-ID: <20010910221448.E30149@emma1.emma.line.org>
Mail-Followup-To: kuznet@ms2.inr.ac.ru, alan@lxorguk.ukuu.org.uk,
	wietse@porcupine.org, linux-kernel@vger.kernel.org,
	linux-net@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <20010910100537.W26627@khan.acc.umu.se> <200109101936.XAA00707@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <200109101936.XAA00707@ms2.inr.ac.ru>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Sep 2001, kuznet@ms2.inr.ac.ru wrote:

> (BTW Matthias, while applying it to my tree, I noticed that
> it does not check for SIOGGIFNETMASK. It would be better to do this only
> when it is meaningful: I see only SIOGGIFNETMASK and SIOGGIFBROADCAST).

Thanks for reviewing it again.

However, I think it should not be complicated. It's clear, simple and
can easily be understood.

Further reasons:

1/ It's not worth it.

  a/ If someone configures two IP addresses for a P2P-interface,
  something is wrong in a different part of the kernel, so
  SIOCGIFDSTADDR need not be exempt.

  b/ Treating SIOCGIFADDR the same way as SIOCGIFNETMASK has the
  advantage that kernels with 4.3BSD ioctl interface (Linux up to 2.2.19
  and 2.4.9) will return the first address of the interface rather than
  the alias address passed in. This way, an application can check if the
  kernel's ioctl interface is really IP alias aware, by just matching
  the ifr it passed in against the one it got back after SIOCGIFADDR.

  I have actually sent a patch to Wietse Venema which lets Postfix warn
  about alias interface addresses that it cannot obtain the netmasks for
  and just skip them, so it does not treat something it does not know
  how to handle.

2/ The search-for-ifa code is unconditionally called upon entry to that
   function. If it depends on the ioctl, it will confuse all people that
   expect all SIOCGIF* ioctls to have the same search properties and
   hinder debugging of applications.

Let's keep this as simple as possible. Performance is not an issue,
ioctl is not read, you don't call it from tight inner loops. Let's not
make it more error prone than it needs to be.

-- 
Matthias Andree
Outlook (Express) users: press Ctrl+F3 for the full source code of this post.
begin  dont_click_this_virus.exe
end
