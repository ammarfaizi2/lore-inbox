Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261782AbVASRNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbVASRNI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 12:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbVASRMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 12:12:47 -0500
Received: from mail.joq.us ([67.65.12.105]:25772 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261778AbVASRLd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 12:11:33 -0500
To: Con Kolivas <kernel@kolivas.org>
Cc: linux <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       rlrevell@joe-job.com, paul@linuxaudiosystems.com,
       CK Kernel <ck@vds.kolivas.org>, Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [PATCH][RFC] sched: Isochronous class for unprivileged soft rt
 scheduling
References: <41ED08AB.5060308@kolivas.org> <87is5tx61a.fsf@sulphur.joq.us>
	<41EE2987.1040005@kolivas.org>
From: "Jack O'Quin" <joq@io.com>
Date: Wed, 19 Jan 2005 11:12:48 -0600
In-Reply-To: <41EE2987.1040005@kolivas.org> (Con Kolivas's message of "Wed,
 19 Jan 2005 20:33:59 +1100")
Message-ID: <873bwxpckv.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=


[including Rui Nuno Capela in cc: list]

>> Con Kolivas <kernel@kolivas.org> writes:
>>
>>>This patch for 2.6.11-rc1 provides a method of providing real time
>>>scheduling to unprivileged users which increasingly is desired for
>>>multimedia workloads.

> Jack O'Quin wrote:
>> I ran some jack_test3.2 runs with this, using all the default
>> settings.  The results of three runs differ quite significantly for no
>> obvious reason.  I can't figure out why the DSP load should vary so
>> much.

Con Kolivas <kernel@kolivas.org> writes:
> I installed a fresh jack installation and got the test suite. I tried
> running the test suite and found it only ran to completion if I
> changed the run time right down to 30 seconds from 300. Otherwise it
> bombed out almost instantly at the default of 300. I don't know if
> that helps you debug the problem or not but it might be worth
> mentioning.

Here are a couple of bug fixes for the test package.  I still had not
gotten them to Rui (the test author).  He has created several newer
versions, but I'm still using this modified jack_test3.2, so the
number comparisons will continue to make sense.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=jack_test3.2-joq.diff
Content-Description: joq mods to jack_test3.2

--- jack_test3.2/jack_test3_client.cpp	Thu Dec  9 10:26:12 2004
+++ jack_test/jack_test3_client.cpp	Sat Jan 15 20:48:20 2005
@@ -13,20 +13,25 @@
 unsigned int seconds_to_run = 60;
 unsigned int num_of_ports   = 4;
 
+/* mix all the input ports to each output port */
 int process(jack_nframes_t frames, void *arg) 
 {
 	// std::cout << "process callback" << std::endl;
 	jack_default_audio_sample_t *ibuf;
 	jack_default_audio_sample_t *obuf;
 	for (int i = 0; i < num_of_ports; i++) {
-		obuf = (jack_default_audio_sample_t*) jack_port_get_buffer(oports[i], frames);
+		obuf = (jack_default_audio_sample_t*)
+			jack_port_get_buffer(oports[i], frames);
 		for (int j = 0; j < num_of_ports; j++) {
-			ibuf = (jack_default_audio_sample_t*) jack_port_get_buffer(iports[j], frames);
-			for (jack_nframes_t frame = 0; frame < frames; frame++) {
+			ibuf = (jack_default_audio_sample_t*)
+				jack_port_get_buffer(iports[j], frames);
+			for (jack_nframes_t frame = 0;
+			     frame < frames; frame++) {
 				if (j == 0)
 					obuf[frame] = 0.0; 
 				if (ibuf[frame] < -1E-6 || ibuf[frame] > +1E-6)
-					obuf[frame] += ibuf[frame] / (float) num_of_ports;
+					obuf[frame] += ibuf[frame]
+						/ (float) num_of_ports;
 			}
 		}
 	}
@@ -68,10 +73,23 @@
 	for (int i = 0; i < num_of_ports; i++) {
 		std::stringstream iport_name;
 		iport_name << "in_" << i;
-		iports[i] = jack_port_register(client,  iport_name.str().c_str(), JACK_DEFAULT_AUDIO_TYPE, JackPortIsInput|JackPortIsTerminal, 0);
+		iports[i] =
+			jack_port_register(client,
+					   iport_name.str().c_str(),
+					   JACK_DEFAULT_AUDIO_TYPE,
+					   JackPortIsInput|JackPortIsTerminal,
+					   0);
 		std::stringstream oport_name;
 		oport_name << "out_" << i;
-		oports[i] = jack_port_register(client, oport_name.str().c_str(), JACK_DEFAULT_AUDIO_TYPE, JackPortIsTerminal|JackPortIsOutput, 0);
+		oports[i] = jack_port_register(client,
+					       oport_name.str().c_str(),
+					       JACK_DEFAULT_AUDIO_TYPE,
+					       JackPortIsTerminal|JackPortIsOutput,
+					       0);
+		if ((iports[i] == NULL) || (oports[i] == NULL)) {
+			std::cout << "port registration failed" << std::endl;
+			goto exit;
+		}
 	}
 	std::cout << "set_process_callback" << std::endl;
 	jack_set_process_callback(client, process, 0);
@@ -85,6 +103,8 @@
 	sleep(seconds_to_run);
 
 	jack_deactivate(client);
+
+exit:
 	jack_client_close(client);
 	
 	delete [] iports;
--- jack_test3.2/jack_test3_nmeter.c	Sat Nov 27 09:08:01 2004
+++ jack_test/jack_test3_nmeter.c	Thu Dec 30 07:50:38 2004
@@ -21,7 +21,9 @@
 //==============
 #define NL "\n"
 typedef unsigned long long ullong;
+#ifndef __USE_MISC
 typedef unsigned long ulong;
+#endif
 
 typedef ulong sample_t;
 
--- jack_test3.2/jack_test3_run.sh	Fri Dec 10 06:21:21 2004
+++ jack_test/jack_test3_run.sh	Sat Jan 15 22:23:06 2005
@@ -6,12 +6,14 @@
 CLIENTS=$2
 PORTS=$3
 PERIOD=$4
+PLYBK_PORTS=$5
 
 # Parameter defaults.
 [ -z "${SECS}"    ] && SECS=300
 [ -z "${CLIENTS}" ] && CLIENTS=20
 [ -z "${PORTS}"   ] && PORTS=4
 [ -z "${PERIOD}"  ] && PERIOD=64
+[ -z "${PLYBK_PORTS}"  ] && PLYBK_PORTS=32
 
 # Local tools must be on same directory...
 BASEDIR=`dirname $0`
@@ -24,13 +26,13 @@
 NMETER_ARGS="t c i x b m"
 
 # jackd configuration.
-JACKD="/usr/bin/jackd"
+JACKD="jackd"
 JACKD_DRIVER="alsa"
 JACKD_DEVICE="hw:0"
 JACKD_PRIO=60
 JACKD_RATE=44100
-JACKD_PORTS=$(((${CLIENTS} + 1) * ${PORTS} * 2))
-JACKD_ARGS="-v -R -P${JACKD_PRIO} -p${JACKD_PORTS} -d${JACKD_DRIVER} -d${JACKD_DEVICE} -r${JACKD_RATE} -p${PERIOD} -n2 -S -P"
+JACKD_PORTS=$((${CLIENTS} * ${PORTS} * 2 + ${PLYBK_PORTS}))
+JACKD_ARGS="-Rv -p${JACKD_PORTS} -d${JACKD_DRIVER} -d${JACKD_DEVICE} -r${JACKD_RATE} -p${PERIOD} -n2 -P"
 
 # client test configuration.
 CLIENT="${BASEDIR}/jack_test3_client"
@@ -85,6 +87,7 @@
 echo "Number of clients  (CLIENTS) = ${CLIENTS}"	>> ${LOG} 2>&1
 echo "Ports per client     (PORTS) = ${PORTS}"		>> ${LOG} 2>&1
 echo "Frames per buffer   (PERIOD) = ${PERIOD}"		>> ${LOG} 2>&1
+echo "Playback ports (PLYBK_PORTS) = ${PLYBK_PORTS}"	>> ${LOG} 2>&1
 echo >> ${LOG} 2>&1
 
 exec_log "uname -a"
@@ -102,7 +105,7 @@
 ilist_log 
 
 #
-# Lauch nmeter in the background...
+# Launch nmeter in the background...
 #
 echo -n "Launching `basename ${NMETER}`..."
 (${NMETER} ${NMETER_ARGS} >> ${LOG} 2>&1) &
@@ -110,7 +113,7 @@
 echo "done."
 sleep 1
 
-# Lauch the test client suite...
+# Launch the test client suite...
 SLEEP=6
 echo -n "Launching ${CLIENTS} ${CLIENT}(s) instance(s)..."
 for NUM in `seq 1 ${CLIENTS}`; do
@@ -129,7 +132,7 @@
 (sleep ${SLEEP}; killall `basename ${JACKD}`) &
 
 #
-# Lauch jackd and wait for it...
+# Launch jackd and wait for it...
 #
 echo -n "Running `basename ${JACKD}`..."
 exec_log ${JACKD} ${JACKD_ARGS}
@@ -149,7 +152,7 @@
 sleep 1
 sync
 
-# Summary log analynis...
+# Summary log analysis...
 cat ${LOG} | awk -f ${BASEDIR}/jack_test3_summary.awk | tee -a ${LOG}
 
 # Finally, plot log output...
--- jack_test3.2/Makefile	Thu Nov 25 05:28:47 2004
+++ jack_test/Makefile	Sat Jan 15 20:50:04 2005
@@ -1,10 +1,10 @@
 all:	jack_test3_nmeter jack_test3_client
 
 jack_test3_nmeter:	jack_test3_nmeter.c
-	gcc -o jack_test3_nmeter jack_test3_nmeter.c
+	$(CC) -g -o jack_test3_nmeter jack_test3_nmeter.c
 
 jack_test3_client:	jack_test3_client.cpp
-	g++ -o jack_test3_client jack_test3_client.cpp -ljack
+	$(CXX) -g -o jack_test3_client jack_test3_client.cpp -ljack
 
 clean:
 	rm -vf jack_test3_nmeter jack_test3_client

--=-=-=


For completeness, here's Rui's unmodified test package against which
these diff's were generated.


--=-=-=
Content-Type: archive/tar
Content-Disposition: attachment; filename=jack_test3.2.tar.gz
Content-Transfer-Encoding: base64
Content-Description: JACK test version 3.2 (from rncbc)

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
--=-=-=


There's also a modified script for running with nice --20, called
jack_test3_nice.sh.  I hacked it for Ingo's tests.  It really should
be integrated into the main jack_test3_run.sh as an option, but I have
not bothered.  I think we're beyond that at this point, anyway.
Mainly, it proves that per-thread granularity is essential for making
this stuff work.


--=-=-=
Content-Type: text/x-sh
Content-Disposition: attachment; filename=jack_test3_nice.sh
Content-Description: hacked up jack_test3_run.sh for running with nice --20

#!/bin/sh
#

# Command line arguments.
SECS=$1
CLIENTS=$2
PORTS=$3
PERIOD=$4
PLYBK_PORTS=$5

# Parameter defaults.
[ -z "${SECS}"    ] && SECS=300
[ -z "${CLIENTS}" ] && CLIENTS=20
[ -z "${PORTS}"   ] && PORTS=4
[ -z "${PERIOD}"  ] && PERIOD=64
[ -z "${PLYBK_PORTS}"  ] && PLYBK_PORTS=32

# Local tools must be on same directory...
BASEDIR=`dirname $0`

# Make sure our local tools are in place.
(cd ${BASEDIR}; make all > /dev/null) || exit 1

# nmeter configuration.
NMETER="${BASEDIR}/jack_test3_nmeter"
NMETER_ARGS="t c i x b m"

# jackd configuration.
JACKD="jackd"
JACKD_DRIVER="alsa"
JACKD_DEVICE="hw:0"
JACKD_PRIO=60
JACKD_RATE=44100
JACKD_PORTS=$((${CLIENTS} * ${PORTS} * 2 + ${PLYBK_PORTS}))
JACKD_ARGS="-v -p${JACKD_PORTS} -d${JACKD_DRIVER} -d${JACKD_DEVICE} -r${JACKD_RATE} -p${PERIOD} -n2 -P"

# client test configuration.
CLIENT="${BASEDIR}/jack_test3_client"
CLIENT_ARGS="${SECS} ${PORTS}"

# process/thread list configuration.
PIDOF="/sbin/pidof"
PLIST="ps -o pid,tid,class,rtprio,ni,pri,pcpu,stat,comm"

# Log filename.
LOG="jack_test3-`uname -r`-`date +'%Y%m%d%H%M'`.log"

# Command executive and logger.
exec_log ()
{
	CMD="$*"
	echo "-----------------------"		>> ${LOG} 2>&1
	echo "# ${CMD}"				>> ${LOG} 2>&1
	${CMD}					>> ${LOG} 2>&1
	echo					>> ${LOG} 2>&1
}

# Process/thread status loggers.
plist_log ()
{
	PIDS="$*"
	if [ -n "${PIDS}" ]; then
		echo "- - - - - - - - - - - -"	>> ${LOG} 2>&1
		${PLIST} -m ${PIDS}		>> ${LOG} 2>&1
		echo				>> ${LOG} 2>&1
	fi
}


# IRQ thread status loggers.
ilist_log ()
{
	echo "- - - - - - - - - - - -"	>> ${LOG} 2>&1
	${PLIST} --sort -rtprio -e \
	| egrep '(^[ ]+PID|IRQ|jack)'	>> ${LOG} 2>&1
	echo				>> ${LOG} 2>&1
}


#
# Log headings -- show some relevant info...
#
echo "*** Started `date` ***" >> ${LOG} 2>&1

echo >> ${LOG} 2>&1
echo "Seconds to run        (SECS) = ${SECS}"		>> ${LOG} 2>&1
echo "Number of clients  (CLIENTS) = ${CLIENTS}"	>> ${LOG} 2>&1
echo "Ports per client     (PORTS) = ${PORTS}"		>> ${LOG} 2>&1
echo "Frames per buffer   (PERIOD) = ${PERIOD}"		>> ${LOG} 2>&1
echo "Playback ports (PLYBK_PORTS) = ${PLYBK_PORTS}"	>> ${LOG} 2>&1
echo >> ${LOG} 2>&1

exec_log "uname -a"

exec_log "cat /proc/asound/version"
exec_log "cat /proc/asound/cards"

#exec_log "grep . /proc/sys/kernel/*_preemption"
#exec_log "grep . /proc/irq/*/*/threaded"
#exec_log "grep . /sys/block/hd*/queue/max_sectors_kb"

exec_log "cat /proc/interrupts"

# This is just about to be sure...
ilist_log 

#
# Launch nmeter in the background...
#
echo -n "Launching `basename ${NMETER}`..."
(nice -15 ${NMETER} ${NMETER_ARGS} >> ${LOG} 2>&1) &
sleep 2
echo "done."
sleep 1

# Launch the test client suite...
SLEEP=6
echo -n "Launching ${CLIENTS} ${CLIENT}(s) instance(s)..."
for NUM in `seq 1 ${CLIENTS}`; do
	CLIENT_CMDLINE="${CLIENT} ${CLIENT_ARGS}"
	SLEEP=$((${SLEEP} + 3))
	(sleep ${SLEEP}; echo -n "$NUM..."; exec_log ${CLIENT_CMDLINE}) &
done
echo "done."

# Let there be some evidence of process status...
SLEEP=$((${SLEEP} + 6))
(sleep ${SLEEP}; plist_log -C `basename ${JACKD}`; plist_log -C `basename ${CLIENT}`) &

# Let jackd live for extended but limited time...
SLEEP=$((${SLEEP} + ${SECS}))
(sleep ${SLEEP}; killall `basename ${JACKD}`) &

#
# Launch jackd and wait for it...
#
echo -n "Running `basename ${JACKD}`..."
exec_log ${JACKD} ${JACKD_ARGS}
echo "done."
sleep 1

#echo -n "Killing `basename ${CLIENT}`..."
#killall `basename ${CLIENT}` && echo "OK." || echo "FAILED."
#sleep 1

echo -n "Killing `basename ${NMETER}`..."
killall `basename ${NMETER}` && echo "OK." || echo "FAILED."

echo "*** Terminated `date` ***" >> ${LOG} 2>&1

sync
sleep 1
sync

# Summary log analynis...
cat ${LOG} | awk -f ${BASEDIR}/jack_test3_summary.awk | tee -a ${LOG}

# Finally, plot log output...
${BASEDIR}/jack_test3_plot.sh ${LOG}

--=-=-=


What version of JACK do you have?  (jackd --version)

You need a recent CVS version to get all the data collection Rui and
Lee have added.  Looks like you're missing that.  Delay Max is an
important statistic.

You need a *very* recent version (about 10 minutes ago) to fix that
jack_deactivate() segfault.  (see URL below)

> It occasionally would segfault on client exit as well (as you've
> already mentioned). I think we're still in the dark here to be honest.

Try again with JACK 0.99.48.  It's in CVS now, but you probably need
this tarball to get around the dreaded SourceForge anon CVS lag...

   http://www.joq.us/jack/tarballs/jack-audio-connection-kit-0.99.48.tar.gz

The results I get with these versions are a lot more stable.  But,
there are still some puzzles about the scheduling.  Do you distinguish
different SCHED_ISO priorities?  

JACK runs with three different SCHED_FIFO priorities:

  (1) The main jackd audio thread uses the -P parameter.  The JACK
  default is 10, but Rui's script sets it with -P60.  I don't think
  the absolute value matters, but the value relative to the other JACK
  realtime threads probably does.

  (2) The clients' process threads run at a priority one less (59).

  (3) The watchdog timer thread runs at a priority 10 greater (70).

  (4) LinuxThreads creates a manager thread in each process running
  one level higher than the highest user realtime thread priority.
-- 
  joq

--=-=-=--
