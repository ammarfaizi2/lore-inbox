Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136710AbREHByj>; Mon, 7 May 2001 21:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136731AbREHByU>; Mon, 7 May 2001 21:54:20 -0400
Received: from mpdr0.chicago.il.ameritech.net ([206.141.239.142]:31483 "EHLO
	mailhost.chi.ameritech.net") by vger.kernel.org with ESMTP
	id <S136710AbREHByK>; Mon, 7 May 2001 21:54:10 -0400
Message-ID: <3AF751B8.8AE5C6DC@ameritech.net>
Date: Mon, 07 May 2001 20:54:00 -0500
From: watermodem <aquamodem@ameritech.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-ac14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Zack Brown <zbrown@tumblerings.org>
CC: Phillipus Gunawan <mr_phillipus@yahoo.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Help: kernel-2.4.4 and iptables: Error?
In-Reply-To: <Pine.LNX.3.96.1010507063343.8114I-100000@renegade>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zack Brown wrote:
> 
> Can someone help this guy?
> 
> --
> Zack Brown
> 
> On Mon, 7 May 2001, Phillipus Gunawan wrote:
> 
> > I'm having problem with iptables...
> > I just upgrade my kernel from 2.2.16 to 2.4.3
> > I also upgrade the iptables with: iptables-1.2.1a-1.i386.rpm
> > After the installation finished, I try to test it with: iptables -L
> > Here's what I've seen on my screen:
> >
> > modprobe: Can't locate module ip_tables
> > iptables v1.2.1a: can't initialise iptables table 'filter': Module is wrong version
> > Perhaps iptables or your kernel needs to be upgraded.
> >
> > I install the iptables-1.2.1a-1.i386.rpm first and then upgrade my kernel.
> > The way I upgrade my kernel:
> >
> > make mrproper
> > make dep bzImage
> > make modules
> > make modules_install
> > cp .........
> > cp....
> >
> > I've choose all option regarding iptables 'netfilter'
> > My friend said I might built netfilter with the ipfwadm
> > compatibility compiled in, which is mutually exclusive with iptables
> > and ipchains support. I didn't build ipfwadm and all other modules I compiled as modules ('M' instead of 'Y')
> >
> > But I still can't understand, it still doesn't work...
> >
> > Could you please help me. I've tried everywhere asking this question, still, nobody can answer it
> >
> > Thank You.
> > Best Regards,
> >
> >
> > Phillipus.
> >

I have it running fine in 2.4.3 driven off of an entry in one of the
rc.d scripts. Try to complile it after your kernel and modules are
built. (That is the way I did it).
  Note: "{a}.{b}.{c}.{d}" represent specific devices behind your NAT
gateway. 


Example entry:
  start)
        echo -n "Starting ADSL service: "

        # Load up the PPP/ATM/ADSL Module, then "dial" in
    [ -z "`/sbin/lsmod | /bin/grep idt77105`"] && \
       /sbin/insmod idt77105

        [ -z "`/sbin/lsmod | /bin/grep nicstar`" ] && \
           /sbin/insmod nicstar

        /usr/sbin/pppd call adsl_service_script

        # Load up some of the IP Masquerade modules
        /sbin/modprobe ip_nat_ftp
        /sbin/modprobe ip_conntrack_ftp
        # /sbin/modprobe ip_masq_irc
        # /sbin/modprobe ip_masq_quake
        # /sbin/modprobe ip_masq_raudio
        # /sbin/modprobe ip_masq_user
        # /sbin/modprobe ip_masq_vdolive

        # Set up IP Masquerade forwarding policies,
        # port forwarding policies & stealth policies
        /sbin/modprobe ip_tables
        /usr/local/sbin/iptables -t nat -A POSTROUTING -o ppp0 -j
MASQUERADE
         #an FTP tunnel
        /usr/local/sbin/iptables -t nat -A PREROUTING \
           -i ppp0 --protocol tcp --dport 4223 -j DNAT --to
{a}.{b}.{c}.{d}:23
        /usr/local/sbin/iptables -t nat -A PREROUTING \
           -i ppp0 --protocol tcp --dport 4224 -j DNAT --to
{a}.{b}.{c}.{d}:24
        #needed for NORTEL VPN
    /usr/local/sbin/iptables -t nat -A PREROUTING \
       -i ppp0 --protocol tcp --dport 500 -j DNAT --to
{a}.{b}.{c}.{e}:500
   /usr/local/sbin/iptables -t nat -A PREROUTING \
       -i ppp0 --protocol udp --dport 500 -j DNAT --to
{a}.{b}.{c}.{e}:500
        #kill any M$ networking
        /usr/local/sbin/iptables -t filter -A INPUT \
           -i ppp0 --protocol tcp --dport 137:139 -j DROP
        /usr/local/sbin/iptables -t filter -A INPUT \
           -i ppp0 --protocol udp --dport 137:139 -j DROP
 
        touch /var/lock/subsys/adsl
 
        echo_success ""
        echo
        ;;
