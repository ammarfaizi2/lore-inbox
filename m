Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131380AbRA2OlA>; Mon, 29 Jan 2001 09:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131530AbRA2Oku>; Mon, 29 Jan 2001 09:40:50 -0500
Received: from [194.213.32.137] ([194.213.32.137]:2564 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S131380AbRA2Oki>;
	Mon, 29 Jan 2001 09:40:38 -0500
Message-ID: <20010129010202.G1300@bug.ucw.cz>
Date: Mon, 29 Jan 2001 01:02:02 +0100
From: Pavel Machek <pavel@suse.cz>
To: Linda Walsh <law@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4 Cpu usuage (display oddities more than anything)
In-Reply-To: <3A7381C2.C512B76C@sgi.com> <3A738289.4F7CBBFA@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <3A738289.4F7CBBFA@sgi.com>; from Linda Walsh on Sat, Jan 27, 2001 at 06:23:05PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Some oddities w/kapmd(2.4.0)...  If I sit in X and do nothing other than run top or
> "vmstat 5", I get down to as low as 60% idle and 40% in system -- with kapmd getting
> 'charged' for the 40%.

At least you can see how kapmd mechanism actually works.

> Then I go and run 'freeamp' and the CPU usage goes to 100% idle, presumably because
> kapmd never gets called because it's never in the idle loop for longer than 333ms.
> 
> It's just weird and unnatural.
> 
> Also forgive my ignorance but is it really possible playing VBR MP3's takes 0 measurable
> CPU?  I've run the program for hours and a ps of 'freeamp' show either no measured cpu 
> time or maybe 1 second...the kernel runs at at 100% idle for most of the time.
> I thought mp3 decompression was a cpu intensive
> operation....weird...

Those counters are running. Try this one:

/*
 * This is simple program which should show weak spots in linux's scheduler
 */

#include <stdio.h>
#include <time.h>
#include <sys/timeb.h>
#include <unistd.h>

int startgame;

int
ticks( void )
{
struct timeb tb;
int sec, msec;
ftime( &tb );
sec = tb.time - startgame;
msec = tb.millitm;
return sec * 1000 + msec;
}

void
main( int argc, char *argv[] )
{
int delta, badboy = 0, count = 1000000;
int t1, t2;

startgame = time(NULL);
if (argc>1) { 
  badboy = 1; 
  printf( "I'm a *BAD* boy! " );
  usleep( 100000 );
  t1 = ticks();
  usleep( 100000 );
  t2 = ticks();
  delta = t2-t1;
  printf( "And bad boys know that jiffie is %dmsec\n", delta );
  delta = 10;
  }
else { printf( "I'm a good boy.\n" ); delta = 20; }
while(1) {
  if ((ticks()-t1) % delta > ((delta * 17)/20))
    if (badboy)
      usleep(10000);
  if (!((--count)%100000)) { printf( "." ); fflush( stdout ); }
  if (!count) break;
  }
}

it used to work. Bad boy used to be charged 0% cpu even if it ate 70%

> I guess I'm thinking -- maybe time in kapmd should be counted as 'idle'?

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
