Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261671AbVF0AcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbVF0AcW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 20:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbVF0AcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 20:32:21 -0400
Received: from mail13.syd.optusnet.com.au ([211.29.132.194]:61915 "EHLO
	mail13.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261671AbVF0Abo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 20:31:44 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17087.18663.601754.480257@wombat.chubb.wattle.id.au>
Date: Mon, 27 Jun 2005 10:31:35 +1000
To: Paolo Marchetti <natryum@gmail.com>
Cc: kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: ondemand+conservative=condemand
In-Reply-To: <cc27d5b10506251801320fde44@mail.gmail.com>
References: <cc27d5b10506251801320fde44@mail.gmail.com>
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Paolo" == Paolo Marchetti <natryum@gmail.com> writes:

>> Just change defaults in conservative governor to make it more
>> responsive.
>> 
Paolo> Alexey, I played with conservative governor trying to make it
Paolo> work decently on my p4 with no results.  As you know it works
Paolo> but it isn't responsive, it takes eons to step up/down.

You can always use a userspace governer.  I've attached the one I use.

Every five seconds (you can make it faster if you wish, but that seems
about right for my usage patterns), the program reads the load
average, and decides whether to adjust the CPU frequency.  If the one
second load average is above $FASTTRESHHOLD, the frequency will be
stepped up by $FASTINC; otherwise if it's above $SLOWTHRESHHOLD, it's
incremented by $SLOWINC.  If the 15-second load average is below
$DECTHRESSHOLD, the frequency is stepped downwards by $DEC.  So you
get fast increases, and slow decreases, but becasue the time constant
for the decrease is long, you can get good response for a load spike,
then fairly rapid decrease.  The aim is to keep the load average
around 0.9.


--
#!/bin/sh

# Seconds to sleep between adjustments
INTERVAL=5

# The controller increments the throttling state by FASTINC
# if the load average is over FASTTRHESHHOLD.
# Thresholds are in percentage points load average -- i.e., the one
# second  load average of 1.0 corresponds to a threshold of 100.
FASTINC=3
FASTTHRESHOLD=100
# Slow increment
SLOWINC=1
SLOWTHRESHOLD=80
# Decrement
DEC=1
DECTHRESHOLD=500

cd /sys/devices/system/cpu/cpu0/cpufreq

# Do some parameter checks.
[ $FASTTHRESHOLD -le $SLOWTHRESHOLD ] && {
    echo >&2 "Fast Threshold $FASTTHRESHOLD must be greater than the"
    echo >&2 "slow threshold $SLOWTHRESHOLD"
    exit 1
}

[ \( $SLOWINC -ge 1 \) -a  \( $FASTINC -ge 1 \) -a \( $DEC -ge 1 \) ] || {
    echo >&2 "Increments must all be small integers in the range 1 to  7"
    exit 1
}

# convert a two dec place number to an int scaled by 100.
function to_int()
{
        val=$1
	OIFS="$IFS"
	IFS="."
	set  $val
	IFS="$OIFS"
	expr $1 \* 100 + $2
}

# get load averages
function loadavg()
{
	read onesec fivesec fifteensec rest < /proc/loadavg
	onesec=`to_int $onesec`
	fifteensec=`to_int $fifteensec`
}

function getspeeds()
{
    echo userspace > scaling_governor
    set `cat scaling_available_frequencies`
    i=0
    for j
    do
	i=`expr $i + 1`
	eval speed$i=$j
    done
    nspeeds=$i
}

# Get current throttling factor.
# This can be changed automatically by the BIOS in response to power
# events (e.g., AC coming on line).
function throttle() {
	< scaling_cur_freq read curfreq
	i=1;
	while [ $i -lt $nspeeds ]
	do
	    eval [ \$speed$i -eq 0$curfreq ] && expr $nspeeds - $i
	    i=`expr $i + 1`
        done
}

function set_speed() {
        x=`expr $nspeeds - $1`
	eval speed=\$speed$x
	echo $speed  > scaling_setspeed
}

# Increase the effective processor speed.
function up()
{
	 [ $current_throttle -eq 0 ] || {
		current_throttle=`expr $current_throttle - $1`
		[ $current_throttle -lt 0 ] && current_throttle=0
		set_speed $current_throttle
         }
}

# Decrease the effective processor speed.
function down()
{
	 [ $current_throttle -eq $nspeeds ] || {
		current_throttle=`expr $current_throttle + $1`
		[ $current_throttle -gt $nspeeds ] && current_throttle=$nspeeds
		set_speed $current_throttle
	}
}


getspeeds
current_throttle=`throttle`
while sleep $INTERVAL
do
	loadavg

	# Go up fast, then tail off.
	#
	if [ $onesec -gt $FASTTHRESHOLD ]
	then
		up $FASTINC
	elif [ $onesec -gt $SLOWTHRESHOLD ] 
	then
		up $SLOWINC
	elif [ $fifteensec -lt $DECTHRESHOLD ]
	then
		down $DEC
	fi
done
