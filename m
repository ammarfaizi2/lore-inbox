Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <971571-26836>; Mon, 13 Jul 1998 08:34:46 -0400
Received: from val3-140.abo.wanadoo.fr ([193.252.196.140]:62147 "EHLO lw2l.bnc.interdrome.fr" ident: "IDENT-NONSENSE") by vger.rutgers.edu with ESMTP id <970842-26836>; Mon, 13 Jul 1998 08:34:22 -0400
From: Andrew Derrick Balsa <andrebalsa@altern.org>
Reply-To: andrebalsa@altern.org
To: Jamie Lokier <lkd@tantalophile.demon.co.uk>
Subject: [TEST CODE] for the new time.c routine
Date: Mon, 13 Jul 1998 15:34:50 +0200
X-Mailer: KMail [version 0.7.9]
Content-Type: Multipart/Mixed; boundary="Boundary-=_XrJmOWFrxsjyBldbEFSArCBynEcd"
Cc: linux-kernel@vger.rutgers.edu, "C. Scott Ananian" <cananian@lesser-magoo.lcs.mit.edu>
References: <19980713142208.65263@tantalophile.demon.co.uk>
MIME-Version: 1.0
Message-Id: <98071315515900.00441@lw2l.bnc.interdrome.fr>
Sender: owner-linux-kernel@vger.rutgers.edu


--Boundary-=_XrJmOWFrxsjyBldbEFSArCBynEcd
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

Hi Jamie,

On Mon, 13 Jul 1998, Jamie Lokier wrote:
>C. Scott Ananian wrote:
>> and I really doubt that many people (without the use
>> of said test suite) would be able to tell that their sub-jiffy timings
>> were saturating early at the mark just before the next jiffy because the
>> CPU was slowing the clock.
>
>It does make smooth video animation a bit jittery, but it's not the end
>of the world as long as jiffies are still working.

I can assure you that the jitter you see in the video animation is _not_
caused by the new time.c code.

It's just that Linux doesn't provide (yet) the fundamental mechanisms for some
multimedia applications: POSIX support for RT code.

In fact, the new time.c code will actually _help_ implement POSIX compatibility.
>
>I remember a laptop with power saving totally screwing up the jiffies.
>(Presumably APM support needed to be in the kernel, and it wasn't).
>That was bad, but the above isn't.

The original time.c code would break with APM. The new one doesn't.

Scott suggested we need a time.c test suite. Here is a short piece of code I
wrote that produces two fancy graphs on your X display. It really tests the
gettimeofday() code. It also shows Linux' present shortcomings when it comes to
RT applications.

Run it on an idle machine and you will see clearly those nice orderly timer
interrupts. Run it on a busy machine and you will see the busy waits and
non-interruptible drivers in the kernel wreaking havoc with timer interrupts.

Cheers,
---------------------
Andrew D. Balsa
andrebalsa@altern.org

BTW Sorry for my earlier base-64 encoded attachments. From now on, only plain
text attachments. Thanks to Andrew E. Mileski for the tip.


--Boundary-=_XrJmOWFrxsjyBldbEFSArCBynEcd
Content-Type: text/english;
  name="jitter.c"
Content-Transfer-Encoding: 8bit
Content-Description: Part of a test suite for time.c
Content-Disposition: attachment; filename="jitter.c"

/* jitter.c - version 0.1 - 20/05/98
 * Linux gettimeofday() call jitter / interrupt latency measurement.
 * Copyright (C) 1998 André D. Balsa.
 * Licensing: GNU/GPL.
 *
 * Compile with: gcc -o jitter jitter.c -lm
 *
 * DON'T use -O2 to compile!
 *
 * usage: jitter [-p]
 *
 * -p : this option uses gnuplot to produce two graphics (in pbm format)
 * of jitter peaks, which can later be viewed using xv. Very fancy stuff,
 * watching the timer interrupts, daemon activity, etc.
 * The first graphic shows the variations in jitter amplitude.
 * The second graphic is a frequency histogram of jitter values.
 * The pbm files are saved in /tmp.
 *
 * The purpose of this program is to show that even when a high
 * precision and high resolution timer mechanism is used (in this case
 * the BSD 4.3 standard gettimeofday() call), Linux, being a non-RT OS,
 * cannot _guarantee_ a stable response time. Check RT-Linux if you need
 * (better than 1 jiffy) accurate timing in any application.
 *
 * The main loop code was adapted from the Whetstone C source
 * (the list of authors is reproduced below). We just want a standard piece
 * of code which will execute in a fixed number of CPU clock cycles.
 *
 * The program works as follows:
 * - We execute a main loop of short duration (1 ms), so short in fact
 *   that in most cases it's not even disturbed by the main system timer
 *   interrupt (100Hz on i386 machines).
 * - We measure the real (as opposed to CPU) time interval between the
 *   beginning and end of our main loop. This measurement, if our main loop
 *   is not interrupted, is a stable value +/- the resolution of our timestamp
 *   call (which for gettimeofday() is 1 microsecond in Linux).
 * - The measurement is repeated MAXCOUNT times (usually 1000). This gives
 *   us a snapshot of what happens during approx. 1 second of real time.
 * - Finally, we calculate the jitter relative to the lowest measurement,
 *   for each measurement, and the frequencies for the various jitter values.
 * - The program then prints the results or plots the graphics.  
 *
 *****************************************************************
 *     C/C++ Whetstone Benchmark Single or Double Precision
 *
 *     Original concept        Brian Wichmann NPL      1960's
 *     Original author         Harold Curnow  CCTA     1972
 *     Self timing versions    Roy Longbottom CCTA     1978/87
 *     Optimisation control    Bangor University       1987/90
 *     C/C++ Version           Roy Longbottom          1996
 *     Compatibility & timers  Al Aburto               1996
 *
 *****************************************************************
 */

#include <stdio.h>
#include <unistd.h>
#include <sys/time.h>

#include <math.h>

#define HAVE_XV		/* define this if you want to view the graphs with xv */

#define MAXCOUNT 1000	/* a 1s run will show the longer timer interrupts */
			/* define a smaller value until sl and bl below are
			   adjusted for a millisecond loop duration */

#define SL 20		/* adjust these two values to get a 1 ms loop */
#define BL 14

int main(int argc, char *argv[]) {

	FILE *fp;
	unsigned int i, ix, loopcount;
	char plot = 0;

	long int timea;
	long int noise = 0;
	long int timeb[MAXCOUNT];
	struct FreqData {
		long int jitval;
		long int freqval;
	};
	struct FreqData freq[MAXCOUNT];	/* most of it unused */

	struct timeval trt;

	double t  = 0.49999975;
	double t2 = 2.0;
	double x, y, t0;

if (argc > 1)
	if (strcmp(argv[1],"-p") == 0)
		plot = 1;	/* plot results to PBM files using gnuplot */


/* Get time intervals in microseconds */
/* Assumption: the loop executes in < 1 second */

	   t0 = t;
	   for (loopcount = 0; loopcount < MAXCOUNT; loopcount++) {

	   gettimeofday(&trt, NULL);
	   timea = trt.tv_usec; /* we only want the microsecond data */

	   /* From section 5, Trig functions, Whetstone source */
	        x = 0.5;
	        y = 0.5;
		{
	            for (ix=0; ix<BL; ix++)
	              {
	                for(i=1; i<SL; i++)
	                  {
	                     x = t*atan(t2*sin(x)*cos(x)/(cos(x+y)+cos(x-y)-1.0));
	                     y = t*atan(t2*sin(y)*cos(y)/(cos(x+y)+cos(x-y)-1.0));
	                  }
	                t = 1.0 - t;
	              }
	            t = t0;
	         }
	   gettimeofday(&trt, NULL);
	   timeb[loopcount] = trt.tv_usec - timea; /* our loop duration */
	   
	   /* We don't check the carry to trt.tv_sec here. 
	      Negative loop durations are adjusted below.
	    */
	}

/* Jitter is calculated relative to the lowest loop duration.
 */
	
	printf("\nJitter analysis\n\n");
	timea = timeb[0];	/* get lowest duration in timea */
				/* and also adjust negative durations */
	
	for (loopcount = 0; loopcount < (MAXCOUNT); loopcount++) {
		if (timeb[loopcount] < 0) timeb[loopcount] += 1000000;
		if (timea > timeb[loopcount]) timea = timeb[loopcount];
		/* also initialize freq[] array */
		freq[loopcount].jitval = 0;
		freq[loopcount].freqval = 0;
		
	}
	/* Calculate histogram data.
	 * Jitter values of 0, 1 and 2 are treated as "noise".
	 */
	for (loopcount = 0; loopcount < (MAXCOUNT); loopcount++) {
		if ((timeb[loopcount] - timea) <= 2) {
		    noise++;
		}
		else {
	/* We want the frequency and jitter values of anything that isn't
	   noise, in increasing order of jitter value; we'll store these
	   values in array freq; first array element with jitval = 0
	   signals the end of the valid values in the array.
	 */	
		    i = 0;
		    while ((freq[i].jitval != (timeb[loopcount] - timea)) && (freq[i].jitval != 0)) {
			i++;					        
		    }
		    freq[i].freqval++;
		    freq[i].jitval = timeb[loopcount] - timea;	/* if we reached the end */
		}
	}
	
/* Now print or plot jitter values. */
	if (!(plot)) {	
	
	    /* Print jitter relative to lowest duration.
	     */
	    for (loopcount = 1; loopcount < (MAXCOUNT); loopcount++) { /* discard first result because of cache priming */
	        printf("Jitter %u : %d microseconds\n", loopcount, (timeb[loopcount]
                - timea));
	    }
	    printf("\nNormal loop duration: %d microseconds\n\n", timea); 
	}
	else {
	
	/* First the jitter - time graphic */

	    /* create data file */
	    if ((fp = fopen("/tmp/jitter_res.dat", "w")) == NULL)
	    	exit (1);
	    for (loopcount = 1; loopcount < (MAXCOUNT); loopcount++) { /* discard first result because of cache priming */
	        fprintf(fp, "%d\n", (timeb[loopcount] - timea));
	    }
	    fclose(fp);
	    
	    /* create gnuplot command file */
	    if ((fp = fopen("/tmp/jitter_res.gpt", "w")) == NULL)
	    	exit (1);
	    fprintf(fp, "set term pbm color\n");
	    fprintf(fp, "set xlabel \"%u microseconds sampling rate\"\n", timea);
	    fprintf(fp, "set ylabel \"microseconds\"\n");
	    fprintf(fp, "set logscale y\n");
	    fprintf(fp, "show xlabel\n");
	    fprintf(fp, "show ylabel\n");
	    fprintf(fp, "plot \"/tmp/jitter_res.dat\" title \"gettimeofday() call jitter over approx. 1 second\" with impulses\n");
	    fclose(fp);
	    
	    /* and plot on the display */
	    system("gnuplot /tmp/jitter_res.gpt > /tmp/jitter_res.pbm");
	
	/* Now the jitter frequency histogram graphic */

	    /* create data file */
	    if ((fp = fopen("/tmp/jitter_frq.dat", "w")) == NULL)
	    	exit (1);
	    for (loopcount = 0; loopcount < (MAXCOUNT); loopcount++) {
	        if (freq[loopcount].jitval == 0) break; /* stop if we are done */
	        fprintf(fp, "%d %d\n", freq[loopcount].jitval, freq[loopcount].freqval);
	    }
	    fclose(fp);
	    
	    /* create gnuplot command file */
	    if ((fp = fopen("/tmp/jitter_frq.gpt", "w")) == NULL)
	    	exit (1);
	    fprintf(fp, "set term pbm color\n");
	    fprintf(fp, "set xlabel \"jitter (in microseconds)\"\n");
	    fprintf(fp, "set ylabel \"frequency\"\n");
	    fprintf(fp, "set logscale x\n");
	    fprintf(fp, "show xlabel\n");
	    fprintf(fp, "show ylabel\n");
	    fprintf(fp, "plot \"/tmp/jitter_frq.dat\" title \"gettimeofday() call jitter frequency distribution\" with impulses\n");
	    fclose(fp);
	    
	    /* and plot on the display */
	    system("gnuplot /tmp/jitter_frq.gpt > /tmp/jitter_frq.pbm");

#ifdef HAVE_XV
	    system("xv /tmp/jitter_frq.pbm &");
	    system("xv /tmp/jitter_res.pbm &");
#endif
	}

return (0);	
}	/* end main() */

--Boundary-=_XrJmOWFrxsjyBldbEFSArCBynEcd--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.altern.org/andrebalsa/doc/lkml-faq.html
