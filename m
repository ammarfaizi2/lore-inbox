Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275704AbRIZXqg>; Wed, 26 Sep 2001 19:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275702AbRIZXqT>; Wed, 26 Sep 2001 19:46:19 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:36852 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S275701AbRIZXp5>; Wed, 26 Sep 2001 19:45:57 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Wed, 26 Sep 2001 17:46:05 -0600
To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
        linux-net@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [patch] netconsole - log kernel messages over the network. 2.4.10.
Message-ID: <20010926174605.E1140@turbolinux.com>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	linux-net@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <Pine.LNX.4.33.0109262128320.8277-100000@localhost.localdomain> <Pine.LNX.4.21.0109261635190.957-100000@freak.distro.conectiva> <20010926152909.D1140@turbolinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010926152909.D1140@turbolinux.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 26, 2001  15:29 -0600, adilger wrote:
> On Wed, 26 Sep 2001, Ingo Molnar wrote:
> > sample startup of the netconsole on the server:
> > 
> >      insmod netconsole dev=eth1 target_ip=0x0a000701 \
> >                   source_port=6666 \
> >                   target_port=6666 \
> >                   target_eth_byte0=0x00 \
> >                   target_eth_byte1=0x90\
> >                   target_eth_byte2=0x27 \
> >                   target_eth_byte3=0x8C \
> >                   target_eth_byte4=0xA0 \
> >                   target_eth_byte5=0xA8
> 
> Ugh.  Maybe a wrapper script (netconsole-server) which automates this is
> in order?  I imagine the eth_byteX is a MAC address (or at least that this
> is in the documentation)?

Ok, I read the docs, and this is indeed a target MAC address.  It may still
be easier to accept a regular MAC address like target_mac=XX:XX:XX:XX:XX:XX
as the module parameter (and a target_ip=A.B.C.D).  In any case, here is a
script to automate this (ugly because of the conversions needed).

=========================================================================
#!/bin/sh
prog=netconsole-server
#
# initialize the netconsole using reasonable defaults (normally just the
# client IP address, and possibly the port.  We can determine the MAC
# address of the client system, IP address, the correct device, and verify
# that we are using an ethernet interface (required for netconsole to work).
#
# Andreas Dilger <adilger@turbolinux.com>  Sep 26, 2001

usage()
{
	cat - <<- EOF 1>&2

	Initialize a network message console over UDP.

	usage: $prog [-b] [-d dev] [-m mac] [-p port] target[:port]
		-b       - use broadcast ethernet MAC address
		-m       - specify remote system MAC address (default: detect)
		-p       - local port to use for message traffic (default: 6666)
		-d       - ethernet device to use for messages (default: detect)
		target   - hostname/IP address of remote netconsole-client
		:port    - port on target netconsole-client (default: like -p)
	EOF
	exit 1
}

PATH=$PATH:/sbin:/usr/sbin
PORT=6666

while [ $# -ge 1 ]; do case $1 in
	-b) NOMAC=1 ;;
	-d) DEV=$2; shift ;;
	-m) MAC=$2; shift ;;
	-p) PORT=$2; shift ;;
	*:*) TGT=`echo $1 | sed "s/:.*//"`; TPORT=`echo $1 | sed "s/.*://"` ;;
	*) TGT=$1 ;;
	esac
	shift
done

[ -z "$TGT" ] && usage
[ -z "$TPORT" ] && TPORT=$PORT

ping -c 1 $TGT > /dev/null 2>&1
[ $? -ne 0 ] && echo "$prog: can't ping $TGT" 1>&2 && usage

dquad_to_hex()
{
	echo $1 | sed -e "s/[()]//g" -e "s/\./ /g" | while read I0 I1 I2 I3 ; do
		printf "0x%02X%02X%02X%02X" $I0 $I1 $I2 $I3
	done
}

# output from arp -a of the form:
# good: host.domain (A.B.C.D) at 00:50:BF:06:48:C1 [ether] on eth0
# bad:  ? (A.B.C.D) at <incomplete> on eth0
arp -a | grep $TGT | { read HOSTNAME IPADDR AT MACADDR TYPE ON IFACE;
	[ "$HOSTNAME" = "?" -a -z "$MAC" -a -z "$NOMAC" ] && \
		echo "$prog: can't resolve $TGT MAC" 1>&2 && usage

	[ -z "$MAC" ] && MAC=$MACADDR
	[ -z "$DEV" ] && DEV=$IFACE
	[ "$DEV" = "$IFACE" -a "$TYPE" != "[ether]" ] && \
		echo "$prog: $DEV must be an ethernet interface" 1>&2 && usage
		
	IPHEX=`dquad_to_hex $IPADDR`
	echo $MAC | sed "s/:/ /g" | { read M0 M1 M2 M3 M4 M5;
		if [ -z "$NOMAC" ]; then
			TGTMAC="target_eth_byte0=0x$M0 target_eth_byte1=0x$M1 \
				target_eth_byte2=0x$M2 target_eth_byte3=0x$M3 \
				target_eth_byte4=0x$M4 target_eth_byte5=0x$M5"
		fi
		#insmod netconsole dev=$DEV target_ip=$IPHEX \
		echo dev=$DEV target_ip=$IPHEX \
			source_port=$PORT target_port=$TPORT $TGTMAC
	}
}

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

