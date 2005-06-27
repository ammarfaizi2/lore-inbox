Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261931AbVF0LhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbVF0LhP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 07:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261991AbVF0LhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 07:37:15 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:35830 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261931AbVF0Lgc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 07:36:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YLc/vNNZQC3YA5gNaCxdV5obg1kinp+w2NwwJqN5DGcPspNFmyPXguypdrAEqApT1N5gyBfZ1hgTVVv/YCZrrq8a9JwPztlLiOhGoqkQjgz9QKc92ASPPpvMvQOnZVI5JtGnpMBQSOyovH2v+76F8zitG2TxB5O5ubB3Q98fPbs=
Message-ID: <cc27d5b105062704367ae2e44@mail.gmail.com>
Date: Mon, 27 Jun 2005 13:36:30 +0200
From: Paolo Marchetti <natryum@gmail.com>
Reply-To: Paolo Marchetti <natryum@gmail.com>
To: Peter Chubb <peter@chubb.wattle.id.au>,
       kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: ondemand+conservative=condemand
In-Reply-To: <17087.18663.601754.480257@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <cc27d5b10506251801320fde44@mail.gmail.com>
	 <17087.18663.601754.480257@wombat.chubb.wattle.id.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/05, Peter Chubb <peter@chubb.wattle.id.au> wrote:
> >>>>> "Paolo" == Paolo Marchetti <natryum@gmail.com> writes:
> 
> >> Just change defaults in conservative governor to make it more
> >> responsive.
> >>
> Paolo> Alexey, I played with conservative governor trying to make it
> Paolo> work decently on my p4 with no results.  As you know it works
> Paolo> but it isn't responsive, it takes eons to step up/down.
> 
> You can always use a userspace governer.  I've attached the one I use.
> 
> Every five seconds (you can make it faster if you wish, but that seems
> about right for my usage patterns), the program reads the load
> average, and decides whether to adjust the CPU frequency.  If the one
> second load average is above $FASTTRESHHOLD, the frequency will be
> stepped up by $FASTINC; otherwise if it's above $SLOWTHRESHHOLD, it's
> incremented by $SLOWINC.  If the 15-second load average is below
> $DECTHRESSHOLD, the frequency is stepped downwards by $DEC.  So you
> get fast increases, and slow decreases, but becasue the time constant
> for the decrease is long, you can get good response for a load spike,
> then fairly rapid decrease.  The aim is to keep the load average
> around 0.9.
> 
> 
> --
> #!/bin/sh
> 
> # Seconds to sleep between adjustments
> INTERVAL=5
> 
> # The controller increments the throttling state by FASTINC
> # if the load average is over FASTTRHESHHOLD.
> # Thresholds are in percentage points load average -- i.e., the one
> # second  load average of 1.0 corresponds to a threshold of 100.
> FASTINC=3
> FASTTHRESHOLD=100
> # Slow increment
> SLOWINC=1
> SLOWTHRESHOLD=80
> # Decrement
> DEC=1
> DECTHRESHOLD=500
> 
> cd /sys/devices/system/cpu/cpu0/cpufreq
> 
> # Do some parameter checks.
> [ $FASTTHRESHOLD -le $SLOWTHRESHOLD ] && {
>     echo >&2 "Fast Threshold $FASTTHRESHOLD must be greater than the"
>     echo >&2 "slow threshold $SLOWTHRESHOLD"
>     exit 1
> }
> 
> [ \( $SLOWINC -ge 1 \) -a  \( $FASTINC -ge 1 \) -a \( $DEC -ge 1 \) ] || {
>     echo >&2 "Increments must all be small integers in the range 1 to  7"
>     exit 1
> }
> 
> # convert a two dec place number to an int scaled by 100.
> function to_int()
> {
>         val=$1
>         OIFS="$IFS"
>         IFS="."
>         set  $val
>         IFS="$OIFS"
>         expr $1 \* 100 + $2
> }
> 
> # get load averages
> function loadavg()
> {
>         read onesec fivesec fifteensec rest < /proc/loadavg
>         onesec=`to_int $onesec`
>         fifteensec=`to_int $fifteensec`
> }
> 
> function getspeeds()
> {
>     echo userspace > scaling_governor
>     set `cat scaling_available_frequencies`
>     i=0
>     for j
>     do
>         i=`expr $i + 1`
>         eval speed$i=$j
>     done
>     nspeeds=$i
> }
> 
> # Get current throttling factor.
> # This can be changed automatically by the BIOS in response to power
> # events (e.g., AC coming on line).
> function throttle() {
>         < scaling_cur_freq read curfreq
>         i=1;
>         while [ $i -lt $nspeeds ]
>         do
>             eval [ \$speed$i -eq 0$curfreq ] && expr $nspeeds - $i
>             i=`expr $i + 1`
>         done
> }
> 
> function set_speed() {
>         x=`expr $nspeeds - $1`
>         eval speed=\$speed$x
>         echo $speed  > scaling_setspeed
> }
> 
> # Increase the effective processor speed.
> function up()
> {
>          [ $current_throttle -eq 0 ] || {
>                 current_throttle=`expr $current_throttle - $1`
>                 [ $current_throttle -lt 0 ] && current_throttle=0
>                 set_speed $current_throttle
>          }
> }
> 
> # Decrease the effective processor speed.
> function down()
> {
>          [ $current_throttle -eq $nspeeds ] || {
>                 current_throttle=`expr $current_throttle + $1`
>                 [ $current_throttle -gt $nspeeds ] && current_throttle=$nspeeds
>                 set_speed $current_throttle
>         }
> }
> 
> 
> getspeeds
> current_throttle=`throttle`
> while sleep $INTERVAL
> do
>         loadavg
> 
>         # Go up fast, then tail off.
>         #
>         if [ $onesec -gt $FASTTHRESHOLD ]
>         then
>                 up $FASTINC
>         elif [ $onesec -gt $SLOWTHRESHOLD ]
>         then
>                 up $SLOWINC
>         elif [ $fifteensec -lt $DECTHRESHOLD ]
>         then
>                 down $DEC
>         fi
> done
> 
Thank you, I'll try it.
Unfortunately the problem is: how to get conservative governor work
decently on a p4 laptop?
