Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbRALJLr>; Fri, 12 Jan 2001 04:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbRALJLh>; Fri, 12 Jan 2001 04:11:37 -0500
Received: from chiara.elte.hu ([157.181.150.200]:24590 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129226AbRALJLS>;
	Fri, 12 Jan 2001 04:11:18 -0500
Date: Fri, 12 Jan 2001 10:10:54 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Christoph Lameter <christoph@lameter.com>
Cc: <khttpd-users@zgp.org>, Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: lies, lies and web benchmarks :-)
In-Reply-To: <Pine.LNX.4.21.0101112214040.22231-100000@home.lameter.com>
Message-ID: <Pine.LNX.4.30.0101120854330.758-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 11 Jan 2001, Christoph Lameter wrote:

> I got into a bragging game whose webserver is the fastest with Jim
> Nelson one of the authors of the boa webserver. We finally settled on
> the Zeus test to decide the battle.

may i add my (hopefully comparable) TUX 2.0 numbers to this bragging game
:-)

TUX had logging turned on, a 1-CPU 500 PIII MHz system (with enough RAM)
was used for the test. UP kernel, nohighmem. The used code is 2.4.0-ac4 +
DaveM's zerocopy patch + Jen's blk patch + TUX 2.0 patch.

(to make these results somewhat comparable, what system did you use?)

> First boa won hands down because it supports persistant connections. Boa
> on port 6000. Khttpd on port 80:
>
> clameter@melchi:~$ ./zb localhost /index.html -k -c 215 -n 20000 -p 6000

> Server:                 Boa/0.94.8.3
> Doucment Length:        1666
> Requests per seconds:   590.58

> Server:                 kHTTPd/0.1.6
> Doucment Length:        1666
> Requests per seconds:   196.59

well, TUX supports persistent (keepalive, ie. lightweight) HTTP
connections as well:

over localhost (like the above test) it gives:

 m:~> ./zb localhost /index.html -k -c 215 -n 20000

 Server:                 TUX
 Document Length:        1666
 Complete requests:      20000
 Failed requests:        0
 Requests per seconds:   12658.23

 Connnection Times (ms)
            min   avg   max
 Connect:     0     0    11
 Total:       5    16    31

Over 100mbit Ethernet (using eepro100) TUX does:

 h:~> ./zb m /index.html -k -c 215 -n 20000

 Server:                 TUX
 Document Length:        1666
 Complete requests:      20000
 Failed requests:        0
 Requests per seconds:   6033.18
 Transfer rate:          11002.97 kb/s

 Connnection Times (ms)
            min   avg   max
 Connect:     0     0    12
 Total:       3    32  3250

As visible from the 'Transfer rate', the 100 mbit link is fully saturated.

The eepro100 was not running in zerocopy mode, so all data was copied
once. As a comparison, over 1000 mbit Ethernet with a native zero-copy
driver (SysKonnect), TUX does:

 Server:                 TUX
 Document Length:        1666
 Complete requests:      20000
 Failed requests:        0
 Keep-Alive requests:    20094
 Requests per seconds:   12812.30

 Connnection Times (ms)
            min   avg   max
 Connect:     0     0    12
 Total:      10    16    29

(but the server is at 70% CPU utilization in the gigabit test - the
dual-PIII/500 client is 100% CPU utilized and thus not fast enough to
saturate the server. With two clients it does about 15000 reqs/sec.)

> Then we decided to switch persistant connection off... But boa still wins.
>
> clameter@melchi:~$ ./zb localhost /index.html -c 215 -n 20000 -p 6000

> Server:                 Boa/0.94.8.3
> Doucment Length:        1666
> Requests per seconds:   227.17

with normal, non-keepalive HTTP requests, TUX 2.0 over localhost does:

 m:~> ./zb localhost /index.html -c 215 -n 20000

 Server:                 TUX
 Document Length:        1666
 Complete requests:      20000
 Failed requests:        0
 Requests per seconds:   5154.64

 Connnection Times (ms)
            min   avg   max
 Connect:    11    19    23
 Total:      34    40    45

over 100mbit ethernet (eepro100) it does:

 h:~> ./zb m /index.html -c 215 -n 20000

 Server:                 TUX
 Document Length:        1666
 Complete requests:      20000
 Failed requests:        0
 Requests per seconds:   4435.57

 Connnection Times (ms)
            min   avg   max
 Connect:     1    15  3020
 Total:      18    47  3068

over gigabit SysKonnect zero-copy it does:

 h:~> ./zb mg /index.html -c 215 -n 20000

 Server:                 TUX
 Document Length:        1666
 Requests per seconds:   5327.65

 Connnection Times (ms)
            min   avg   max
 Connect:     0    11    16
 Total:      21    39    81

(but the nonpersistent test puts even more load on the client, the server
is only about 60% utilized - with two clients it does about 8000
reqs/sec.)

at this point i couldnt resist - i assembled a few TUX 2.0 CGI execution
benchmarks. The CGI used for this test is a real, standard Linux ELF CGI
executable which is exec()-ed for every HTTP request: it read()s the same
/index.html file the other tests were using, write()s a HTML header to
stdout, then write()s the /index.html file to stdout and finally write()s
a HTML trailer to stdout and exit()s. [A separate process is created for
every single HTTP request]. Over localhost, TUX 2.0 CGI does:

 m:~> ./zb localhost x?/index.html -c 215 -n 20000

 ---
 Server:                 TUX
 Document Length:        1876
 Complete requests:      20000
 Failed requests:        0
 Requests per seconds:   1227.14

 Connnection Times (ms)
           min   avg   max
 Connect:     1    12    32
 Total:      41   172   346
 ---

over 100 mbit Ethernet (eepro100) TUX 2.0 CGI does:

 Requests per seconds:   1336.18

(the 1000 mbit number is the same as the 100 mbit one, because the server
is saturated executing CGIs already, network bandwidth has no relevance.)

so to conclude the bragging game, (and keeping in mind that mine might be
stronger hardware) here comes a real benchmarketing statement (Microsoft
PR folks turn green with envy): "TUX 2.0 serves CGIs over a real network
faster than boa and khttp serves static content over localhost =B-)"
[ducking down]

but at this point i have to submit that localhost tests are deceptive
because the 'zb' client takes away about half of the CPU power, creates
scheduling storms and skews results in many other ways as well. I'm almost
never testing TUX over localhost, it changes performance characteristics
fundamentally.

The over- 100mbit and 1000mbit numbers are a bit more informative, but
this still does not show lots of other, much more important webserver
characteristics that make the true and visible difference on the real
Internet these days: packet generation efficiency, flow control, caching,
fairness under load, low latency under load, robustness, flexibility,
feature set. Bandwidth and scalability is only at a distant eighth and
nineth place in my list :-)

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
