Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282511AbSBMNoJ>; Wed, 13 Feb 2002 08:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282843AbSBMNoA>; Wed, 13 Feb 2002 08:44:00 -0500
Received: from coruscant.franken.de ([193.174.159.226]:24460 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S282511AbSBMNns>; Wed, 13 Feb 2002 08:43:48 -0500
Date: Wed, 13 Feb 2002 14:33:59 +0100
From: Harald Welte <laforge@gnumonks.org>
To: linux-kernel@vger.kernel.org, netfilter-devel@lists.samba.org
Subject: Re: [netfilter]: FTP connection tracking problem
Message-ID: <20020213143359.P24781@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@gnumonks.org>,
	linux-kernel@vger.kernel.org, netfilter-devel@lists.samba.org
In-Reply-To: <20020212221239.GB2161@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.17i
In-Reply-To: <20020212221239.GB2161@localhost>; from jdomingo@internautas.org on Tue, Feb 12, 2002 at 11:12:39PM +0100
X-Operating-System: Linux sunbeam.de.gnumonks.org 2.4.17
X-Date: Today is Pungenday, the 43rd day of Chaos in the YOLD 3168
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2002 at 11:12:39PM +0100, Jose Luis Domingo Lopez wrote:

> The strange part is that this will show up with just some FTP clients
> and/or remote FTP servers. For example, text-mode web browser "links"
> doesn't work in any case. On the other hand, text-mode browser "lynx"
> works nice in the same places where "links" fails. "wget", "ftp" and
> "ncftp" show various degrees of success with several combinations of
> active/passive transfer mode and remote FTP servers (tried with
> ftp.kernel.org, ftp.at.kernel.org, ftp.mozilla.org, ftp.rediris.es,
> ftp.sourceforge.net).

FTP connection tracking generally works very well.  It's widely deployed
and in most scenarios it is working fine.

The "links" browser is violating the RFC's by not waiting for server
responses after sending PORT commands to the server.  This is a problem
with the browser, and it should be fixed on the browser side.  I doubt
it works well with other ftp masquerading/nat solutions.

I'm a heavy user of wget / ftp / mirror / ncftp, and I've never experienced
any of the problems you describe.  Please give me exact ftp server hostnames
where I can try to reproduce your problem.

> For example, "ftp.rediris.es" won't even show the greeting message with
> "links", but will with for example "ncftp". However, trying to download
> some file from the server, stalls as soon as some kilobytes of data have
> been received (in the order of 8 to 10 KB).

As I said, forget about links. Use ftp or ncftp and you can be sure they
comply to the RFC's.

Some other notes:

- greeting messages are part of the control connection which is not 
  really touched by conntrack.

- I can not imagine how the ftp conntrack helper should cause stalls in
  file transfers.  Are you 100% sure this is caused by netfilter?  Do 
  you see packet drops/ delays when comparing incoming/outgoing packets
  on your firewall?  What happens without ip_conntrack_ftp?  Stalls could
  be network problems in general or bandwith throttling on the server.

- I have just successfully downloaded about 50MB from ftp.rediris.es 
  through a netfilter conntrack+nat box, I get constant transfer rates of 
  about 700kbits/sec on a 1mbit internet uplink.

> If we configure INPUT to not discard packets, and just ACCEPT all that
> comes in solves the proble. ECN is not compiled in nor activated. The rest
> of network-related kernel tunnable parameters have default values.

how are your input rules related to forwarded/NAT'ed traffic through
the firewall?  INPUT rules are for the local machine only.  Or are you
running some ftp/http proxy like squid on the local box?

> I am willing to perform as much tests as you need to help discover what
> is going on, so if I missed something important, please ask.

- tcpdump/ethereral on incoming+outgoing interface. see if there are 
  really packet drops / ack storms / ...
- enable ftp conntrack debugging (in ip_conntrack_ftp.c and ip_nat_ftp.c
  there is something like 

#if 0
#define DEBUGP(format, args...) printk(KERN_DEBUG __FILE__ ":" __FUNCTION__ \
                                        ":" format, ## args)
#else
#define DEBUGP(format, args...)
#endif

just change the "if 0" to "if 1", recompile and reinstall your modules.

you should get detailed debug logs in your syslog for every ftp connection

- what does /proc/net/ip_conntrack say about expectations
- what if you only use ip_conntrack_ftp without nat

> José Luis Domingo López
> Linux Registered User #189436     Debian Linux Woody (P166 64 MB RAM)
>  
> jdomingo AT internautas DOT   org  => Spam at your own risk
> 
> 
> 

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M+ 
V-- PS++ PE-- Y++ PGP++ t+ 5-- !X !R tv-- b+++ !DI !D G+ e* h--- r++ y+(*)
