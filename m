Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280755AbRKGDeu>; Tue, 6 Nov 2001 22:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280754AbRKGDej>; Tue, 6 Nov 2001 22:34:39 -0500
Received: from node1500a.a2000.nl ([24.132.80.10]:44976 "HELO mail.alinoe.com")
	by vger.kernel.org with SMTP id <S280750AbRKGDe1>;
	Tue, 6 Nov 2001 22:34:27 -0500
Date: Wed, 7 Nov 2001 04:34:25 +0100
From: Carlo Wood <carlo@alinoe.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [ircu-development] Slow on high-MTU (local host) connections?
Message-ID: <20011107043425.A15045@alinoe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
PS2 Sent again to the kernel list because I used the wrong address
   the first time.

