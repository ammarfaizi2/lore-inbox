Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129111AbRBSOO5>; Mon, 19 Feb 2001 09:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129155AbRBSOOr>; Mon, 19 Feb 2001 09:14:47 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:33018 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S129111AbRBSOOd>; Mon, 19 Feb 2001 09:14:33 -0500
Date: Mon, 19 Feb 2001 12:27:30 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org, jdthood@yahoo.co.uk
Subject: [PATCH] fix bad dev->refcnt in unregister_netdevice was Re: [PATCH] to deal with bad dev->refcnt in unregister_netdevice()
Message-ID: <20010219122730.A877@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	davem@redhat.com, linux-kernel@vger.kernel.org, jdthood@yahoo.co.uk
In-Reply-To: <20010214092251.D1144@e-trend.de> <3A8AA725.7446DEA0@ubishops.ca> <20010214165758.L28359@e-trend.de> <20010214122244.H7859@conectiva.com.br> <3A8C465D.5E2A118D@ubishops.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
In-Reply-To: <3A8C465D.5E2A118D@ubishops.ca>; from jdthood@ubishops.ca on Thu, Feb 15, 2001 at 04:13:01PM -0500
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	Found it, here's the patch, please apply. Not using auto creation
of interfaces we're using dev_get_by_name, that does a dev_hold, on
ipx_auto_create we're not doing it, duh 8) Tested with several
combinhations of unpluging pcmcia card, just ifconfig eth0 down, etc

- Arnaldo

--- linux-2.4.2-pre4/net/ipx/af_ipx.c	Mon Feb 19 06:00:21 2001
+++ linux-2.4.2-pre4.acme/net/ipx/af_ipx.c	Mon Feb 19 12:15:27 2001
@@ -1194,6 +1194,7 @@
 		atomic_set(&intrfc->refcnt, 1);
 		MOD_INC_USE_COUNT;
 		ipxitf_insert(intrfc);
+		dev_hold(dev);
 	}
 
 	return intrfc;


Em Thu, Feb 15, 2001 at 04:13:01PM -0500, Thomas Hood escreveu:
> Update on the "unregister_netdevice" bug ...
> 
> Arnaldo Carvalho de Melo has been valiantly trying in his
> scarce free time to find the cause.  I haven't been able to
> hunt effectively because I don't really understand the networking
> code; however I have been experimenting to see what are the
> exact conditions under which the failure occurs.  I modified
> my kernel to print dev->refcnt in /proc/net/dev so that I
> could see what the refcnt of eth0 is at any given moment.
> One of the more interesting experiment logs is appended 
> below.
> 
> Experimentation seems to show
> 1) It happens when ipx is used, specifically when 
>    auto_interface=on and auto_primary=on
> 2) It happens only or especially when using DHCP
> 3) It happens only to PCMCIA ethernet cards
> 
> Thomas Hood
> jdthood_AT_yahoo.co.uk
> 
> Linux 2.4.1-ac10
> /etc/pcmcia/network disabled with an 'exit 0'
> 
> command                         refcnt  message
> -------                         ------  -------
> (boot)                               0
> (I inserted Xircom card)             1
> ifconfig eth0 up                     2
> ipx_configure --auto_interface=on --auto_primary=on    2
> ifconfig eth0 down                   0  "Freeing alive device c127ac8c, eth0"
> cardctl eject                        ?  "unregister_netdevice: waiting for
>    eth0 to become free. Usage count = 0
>    Message from syslogd@thanatos at Wed Feb 14 12:51:26 2001 ...
>    thanatos kernel: unregister_netdevice: waiting for eth0 to become free.
>    Usage count = 0"
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
