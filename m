Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280750AbRKGDfj>; Tue, 6 Nov 2001 22:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280754AbRKGDfa>; Tue, 6 Nov 2001 22:35:30 -0500
Received: from cj46222-a.reston1.va.home.com ([65.1.136.109]:23736 "HELO
	sanosuke.troilus.org") by vger.kernel.org with SMTP
	id <S280750AbRKGDfS>; Tue, 6 Nov 2001 22:35:18 -0500
To: linux-kernel@vger.kernel.org
Subject: select() takes a long time after an EAGAIN read()?
From: Entrope <entrope@users.sourceforge.net>
Date: 06 Nov 2001 22:35:31 -0500
Message-ID: <87ofmfs16k.fsf@sanosuke.troilus.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carlo Wood diagnosed a problem that GamesNET has been seeing where
traffic between two processes on the same machine takes a lot longer
using the default configuration than the same traffic between
different machines.  It's apparently entangled in the path MTU -- the
slow transfers happen when the MTU is 16 KB, as in localhost, and does
not happen when the MTU is smaller.  I don't know of any reason it
should do this, and Carlo also chalks it up to kernel weirdness.

Is this a kernel bug, or is it expected (just not by us)?

-- Entrope

-- From his email (originally sent to the old lkml address): --

On Mon, Nov 05, 2001 at 09:17:52PM -0500, Entrope wrote:
> GamesNET's seeing oddly long burst times when we connect srvx to ircu
> on the same machine (~1 minute).  These go away when connecting to
> another machine (connected via 100baseT; ~5 seconds).

I have reproduced this: 74 seconds with MTU == 16436 and 1.8 seconds(!)
with MTU == 8000.

I investigated this tonight and although it seems to be a kernel bug.

What typically happens is this (here process 'ircu' is bursting data
over a socket to process 'srvx2', using `localhost'):

UTC(sec.microsec) [who]   syscall <time spend in syscall>

1005101096.583475 [ircu ] send(6, "or the month: instead of /msg au"..., 1092, 0) = 1092 <0.000013>
1005101096.583551 [ircu ] poll([{fd=6, events=POLLIN}, {fd=5, events=POLLIN, revents=POLLIN},
                          {fd=4, events=POLLIN}, {fd=2, events=POLLIN}, {fd=1, events=POLLIN},
			  {fd=3, events=POLLIN}, {fd=0, events=POLLIN}], 7, 36000) = 1 <0.557834>
1005101096.583681 [srvx2] read(12, "otice from def, posted 08:38 PM,"..., 218556) = 16628 <0.000125>
1005101096.583867 [srvx2] read(12, "ure because you can\'t accidently"..., 201928) = 5432 <0.000041>
1005101096.583963 [srvx2] read(12, 0x401d089a, 196496) = -1 EAGAIN (Resource temporarily unavailable) <0.000007>
1005101096.585688 [srvx2] select(13, [12], [], NULL, {13, 0}) = 1 (in [12], left {12, 440000}) <0.556093>
1005101097.141491 [ircu ] time(NULL)            = 1005101097 <0.000005>
1005101097.141550 [ircu ] recv(5, "zAA NOTICE IXT :[\2users\2] Notice"..., 8192, 0) = 7948 <0.000070>

or

1005101096.040382 [srvx2] read(12, "ed 08:38 PM, 08/05/2001:\r\n:Globa"..., 87316) = 1898 <0.000026>
1005101096.040455 [srvx2] read(12, 0x401ec25e, 85418) = -1 EAGAIN (Resource temporarily unavailable) <0.000012>
1005101096.053036 [srvx2] select(13, [12], [], NULL, {13, 0}) = 1 (in [12], left {12, 740000}) <0.265021>
1005101096.072435 [ircu ] time(NULL)            = 1005101096 <0.000009>
1005101096.072503 [ircu ] send(5, "clan-dk.org Ak6f52 Ih2 :Juped Us"..., 488, 0) = 488 <0.000067>
1005101096.072628 [ircu ] send(5, "172 3 1005101095 JupeUser21 fake"..., 2048, 0) = 2048 <0.000023>
1005101096.072699 [ircu ] send(5, "SrQjW IiT :Juped User!\r\nI NICK J"..., 2048, 0) = 2048 <0.000021>
1005101096.072767 [ircu ] send(5, "005101095 JupeUser22 fake1.clan-"..., 2048, 0) = 2048 <0.000022>
1005101096.072836 [ircu ] send(5, "jC :Juped User!\r\nI NICK JupeUser"..., 2048, 0) = 2048 <0.000024>
1005101096.072909 [ircu ] send(5, "95 JupeUser22 fake1.clan-dk.org "..., 2048, 0) = 2048 <0.000023>
1005101096.072978 [ircu ] send(5, "ed User!\r\nI NICK JupeUser2290 3 "..., 2048, 0) = 2048 <0.000020>
1005101096.073045 [ircu ] send(5, "User23 fake1.clan-dk.org ATPpVB "..., 2048, 0) = 2048 <0.000024>
1005101096.073115 [ircu ] send(5, "!\r\nI NICK JupeUser2337 3 1005101"..., 2048, 0) = 1560 <0.000023>
1005101096.073190 [ircu ] poll([{fd=6, events=POLLIN}, {fd=5, events=POLLIN|POLLOUT, revents=POLLOUT},
                          {fd=4, events=POLLIN}, {fd=2, events=POLLIN}, {fd=1, events=POLLIN},
			  {fd=3, events=POLLIN}, {fd=0, events=POLLIN}], 7, 36000) = 1 <0.233812>
1005101096.307098 [ircu ] time(NULL)            = 1005101096 <0.000005>
1005101096.307154 [ircu ] send(5, "d User!\r\nI NICK JupeUser2355 3 1"..., 488, 0) = 488 <0.000035>

So basically, the long delay inside poll/select happens when
svrx enters select() *after* it got an EAGAIN error on a read().

I suggest to fix this for now by changing srvx to do the following:

- call read() with a small buffer (8 kb or something) and continue
  to call it until an ammount is returned that is less than this 8 kb.
  Then call select() again to see if there is more data.

The point is that when read() returns less than what you ask for,
there will not be more data -- unless you ask for ridiculous ammounts
of data, as you do; then of course it can never return that ammount.

-- 
Carlo Wood <carlo@alinoe.com>

PS CC to kernel list, because I think this delay should not be there.
   If anyone on the kernel list knows what causes this, then please
   CC me as I am not subscribed to this list.

-- Following up on that: --

The examples in the previous mail are from the case with MTU is 8000
(and were to only two occurances of a EAGAIN for read() actually).

Allow me show the statistics for both MTU's:

MTU 16436:

~>grep -B1 '\[srvx2\] select.*<0\.[1-9]' mtu16436 | grep '\[srvx2\] read' | wc --lines
    323
~>grep -B1 '\[srvx2\] select.*<0\.[1-9]' mtu16436 | grep '\[srvx2\] read.*EAGAIN' | wc --lines
    323

Conclusion: ALL calls to select() that took longer than 0.1 second
were following a call to read() that failed with EAGAIN.  In total 323 times.


MTU 8000:

~>grep -B1 '\[srvx2\] select.*<0\.[1-9]' mtu8000 | grep '\[srvx2\] read' | wc --lines
      2
~>grep -B1 '\[srvx2\] select.*<0\.[1-9]' mtu8000 | grep '\[srvx2\] read.*EAGAIN' | wc --lines
      2

Idem, but only two occurences.


The total number of calls to select in both are respectively:

~>grep '\[srvx2\] select.*' mtu16436 | wc --lines
   1221
~>grep '\[srvx2\] select.*' mtu8000 | wc --lines
   658
