Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268123AbTGOOE6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 10:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268177AbTGOOE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 10:04:58 -0400
Received: from 69-55-72-141.ppp.netsville.net ([69.55.72.141]:9428 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S268123AbTGOOEr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 10:04:47 -0400
Subject: Re: RFC on io-stalls patch
From: Chris Mason <mason@suse.com>
To: Jens Axboe <axboe@suse.de>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
       marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
In-Reply-To: <20030715091730.GI833@suse.de>
References: <20030714224528.GU16313@dualathlon.random>
	 <1058229360.13317.364.camel@tiny.suse.com>
	 <20030714175238.3eaddd9a.akpm@osdl.org>
	 <20030715020706.GC16313@dualathlon.random> <20030715054551.GD833@suse.de>
	 <20030715060101.GB30537@dualathlon.random> <20030715060857.GG833@suse.de>
	 <20030715070314.GD30537@dualathlon.random> <20030715082850.GH833@suse.de>
	 <1058260347.4012.11.camel@tiny.suse.com>  <20030715091730.GI833@suse.de>
Content-Type: multipart/mixed; boundary="=-c7hGgCniWnYIwPNEmYLT"
Organization: 
Message-Id: <1058278688.4012.57.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 15 Jul 2003 10:18:09 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-c7hGgCniWnYIwPNEmYLT
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2003-07-15 at 05:17, Jens Axboe wrote:

> > BTW, the contest run times vary pretty wildy.  My 3 compiles with
> > io_load running on 2.4.21 were 603s, 443s and 515s.  This doesn't make
> > the average of the 3 numbers invalid, but we need a more stable metric.
> 
> Mine are pretty consistent [1], I'd suspect that it isn't contest but your
> drive tcq skewing things. But it would be nice to test with other things
> as well, I just used contest because it was at hand.

I hacked up my random io generator a bit, combined with tiobench it gets
pretty consistent numbers.  rio is attached, it does lots of different
things but the basic idea is to create a sparse file and then do io of
random sizes into random places in the file.

So, random writes with a large max record size can starve readers pretty
well.  I've been running it like so:

#!/bin/sh
#
# rio sparse file size of 2G, writes only, max record size 1MB
#
rio -s 2G -W -m 1m &
kid=$!
sleep 1
tiobench.pl --threads 8
kill $kid
wait

tiobench is nice because it also gives latency numbers, I'm playing a
bit to see how the number of tiobench threads changes things, but the
contest output is much easier to compare.  After a little formatting:

Sequential Reads
            File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier  Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
------------ ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.4.22-pre5 1792  4096    8    6.92 2.998%     4.363     9666.86   0.02245  0.00000   231
2.4.21      1792  4096    8    8.40 3.275%     3.052     3249.79   0.00131  0.00000   256

Random Reads
            File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier  Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
------------ ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.4.22-pre5 1792  4096    8    1.41 0.540%    20.932      604.13   0.00000  0.00000   260
2.4.21      1792  4096    8    0.65 0.540%    41.458     2689.96   0.05000  0.00000   120

Sequential Writes
            File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier  Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
------------ ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.4.22-pre5 1792  4096    8   13.77 8.793%     1.550     3416.72   0.00567  0.00000   157
2.4.21      1792  4096    8   15.38 8.847%     1.169    47134.93   0.00719  0.00305   174

Random Writes
            File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier  Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
------------ ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.4.22-pre5 1792  4096    8    0.68 1.470%     0.027       12.91   0.00000  0.00000    46
2.4.21      1792  4096    8    0.67 0.598%     0.043       67.21   0.00000  0.00000   112

rio output:
2.4.22-pre5 total io 2683.087 MB, 428.000 seconds 6.269 MB/s
2.4.21      total io 3231.576 MB, 381.000 seconds 8.482 MB/s
2.4.22-pre5 writes: 2683.087 MB, 6.269 MB/s
2.4.21      writes: 3231.576 MB, 8.482 MB/s

Without breaking tiobench apart to skip the write phase it is hard to
tell where the rio throughput loss is.  My guess is that most of it was
lost during the sequential write tiobench phase.

Since jens is getting consistent contest numbers, this isn't meant to
replace it.  Just another data point worth looking at.  Jens if you want
to send me your current patch I can give it a quick spin here.

-chris


--=-c7hGgCniWnYIwPNEmYLT
Content-Disposition: attachment; filename=rio.c.gz
Content-Type: application/x-gzip; name=rio.c.gz
Content-Transfer-Encoding: base64

H4sICH4MFD8AA3Jpby5jAJ0aaW/bRvaz9CsmKmRTthwf2wZYOc5ukrpBkDhdOC7SRRIQFDmUCFMc
gYcdt/X+9n3HDGeGoly3AhJTw3fNu9+MDveGYk+UUZGolciUWMhCllGtSnFwIF4vy6wSF1GlChGs
8M+/q6aST2O1mhCazGVUyUQ0RSJL8eY/78XNCbw4HH6XyDQrpAh/evv+PPz5p58+nl+Fr95efRTP
vh8Ov8uKOG8SKZ5XdZKpp8sXzpIsy6KzFFWVLGt/DTDzbN5Zu6sO67u1rDaXqzrqEEjjos79pabI
gGyXT5kVC3+tzlayh/PmarYoIuLRKuT1f1+DQi7PX/4ojjuLny7fXp2Lk+GwKRAR1JqrYgFKjkPQ
/bU4Ez8cH58OVZqGtUizXIZV9puE5eMjsMXx0cn3+o+BqVUd5WEpo6QCqCN/+bbMaqnXYY9NDC9g
AzdRLuayiJchaKyst75Ta3gF7IEeCqgl+eH4xFteRd+YQ7yMSrFHQhfRCkE//PL+/ekwK2qRqDCt
7oqYIXFlHdW1LAtc+JaA+HMpU36TJhYK5AdPzVRRuTxoX+G8Sc0C7t/9/pssFX9HIjeynKtKOryz
hB9g30UcqiKMgUJNem5RsvTOKlAvEx9V5HeWFsvirxUqXKrcaH54o7IEjFkkYb0sVbNYrps6wMWJ
+H0o4IM4lYynAgIvPqWlRDXzXAqQD60yFTXg8JuFrHFJpUl0F+xYW01J3ZNThCFAoAUCWICn9U2I
aweu8fUik258FP266UWyomapCBDkhTgSOztM5Lk4MpvTohwcnA4H9G4fvZk+jH9P/+udAvuA9z4h
2PZbgLiHGnHCmKgUByFwg2Hfi4GJOLRgThhpQmuI/zoNRoSCKXL89B+puHg15QfgrAqgqVcPqy/F
aCra3WlJpr61DvW3flldUR8lGoHOOoK1sjD/x7LVbv0ovgz71xjfa5+HFBcuoezksgzIxyHlNSvj
GKlmAekY6sFUjOIIYoOhwArjhBhoHBaqG0R6WX7L6uDEYZxkMuB4rQ03FA0TI2NQmoAE8fnk2dfT
9n2wU2uKURUTQhnkKo5y83KKOB0FjZMZCQAVBLTEWoEE44KSfCiLlVB+q8uIc2LASc8ISqJhAv38
7HstG+kOIMMU8hYrghABiQGqQkuDeFOov6BNhDgoM3UwTlgiA8uEwCnUWhYa4+fwNdSrK/EHPF1d
/vLh9VQcPWvjjCJco3Uiew2mU2UwQlpEGnYCKgDEARrheOLGeFPkWXFNLI1BaR+atl6Lc0jWzppR
GefoEAvMRvYE5TIyl79cYmHR1cmx+N5a64ALHjYM9J/WKlAxamnLmK+byx8/XW6oBtEeUMsWZZAJ
SG6Hd4rSgF2nYgeffCZ9DBBqCwOyGrZEVa1r9xln6E7VQ7KDjWBkt15D9IJjQy4V4/eNmN9BLrAe
3jYoKMBKripZB6b0gpamxgL4GqUxdZE4WmvpxgLKAS3eLtHCtPjcYWFwrLIoNZGyLFOH46Bjm8HA
VRwhk+Zo2ahvMLiHf8R8X5tnwCoddOJucC9kDl2FFkvbj3QbabE8/XQMORgYSVoclqaVRLO932Kc
REFXSRZEAyErYxjjBSwf8uy1uNNdum5y2vpYL9sK2w/NkNH/3DccaX5/mHpT+bRV+ijaHEI9Ub82
bsLdoHUvhH3hxyw4cLy+C6CR2tHN6ZRcU6WYoSdoEsQ6OHNXYXGNnuItsUwgFfs3T14hbiKEFYwS
fgFiTnUMZCoE4tABenMBzgRGRIaDWugmOiRNhDl+vBcL6S4Qd1qlacIZJDj96DfYzUNfsNkPoBvh
y+cOJVd7Hv1W/zZGDveoeovIDKKruWBl4Cw5gH1hm4L6C0xXwtR4cg2og7t8+eHH8OLlr9DdHT89
EmQTqwIwA5LpzEk2IdJ/G3IQqpUEYfqEcfa3XSIUyHCJcjAkBke9lOiUqkw40/lM8M++NvSO+B8+
nBqLePvSlCmF2FfaccCXMeuhol2XQIMdaBCv2ZZ1A7NXC2qLLAVlOI94vQq4bC6USji/tt5KgwAH
SOu+xh/M4majBIQ5mKfYZRMNDHD6htsYNzbKLRNNXbcMqgTToL+LU5GBP2oNwJf9fdcjUVNG8M/Z
V/HkTJg5Eb629cQVb9zMBKKI8XL5KwmLD45I0PW3RQg+DvmpRxzLg6Nvk9ONlsMQhI7vYkhEeqKd
T6mPobU/1fJwa+NTSXkd2qYCVUAkwbWcAwjauwEFTeb4TBXLsvx4fv4u/Hh+ZWp3Cw5qNFBWh7qU
EaGRKV5tJYNtD7olm3Zs7NqWaiauXWmwtUwkimcYVFqsVutcgrvTihkbyFzccndlIWbmQKLl4zbk
ur4PB964tH/WE0lI60lHx3jyM3E9kcPNRXu88g2Tbfo3PDZNsNkRMkP0U+JnHLYTYL22MGwebw4+
QgF7iAAifDZuJt50BBw2Q3yKnTlvhI4IJ5743njvGwNl9s9soM/Fgr5aB3abjs95qnMyQBoBj5kR
Po2gV0icvmrQzY+aZF+iurfjqCKpA7+UG7RTL2e6myooh5qCYrQMD7C/+laxx0MqreARl2mR9QN1
51rKNRQfaKgq3EhpCs9GAj2xuXOgkykUJhZo0tO86A7L6fCheJ0SLmf0s76Wp23arLE9ZLYgHtT9
aezjFlv1UYOoxdblw7T6W6oIRraTge3wYMP3cUblbGbPC/+GfTlznLnZ2cndhmzrqgz+x5kjqgH/
+4bT6H/bdo60xnyPShcPm7CNzgd6Ad34O8Zsm/2pqaVbUHsdYDuKtXqmNk4fYtUUqDl7Wm2V8oRe
TqwF8ev+/qntSHkgYTAKQcRqT5rbYGj97aitaWbFy3xOkXtiD6cnLQpnIh1xVmINQGLgWW3r7OzM
66is2AV0x0JeFpUL06ysmrytRwQRWyfvDi2mZ8HDZkPnM2R+UHVgvk+gcT3+avWI58u7/9z1TpUf
RAXau1+Odt0Cwi13VKvMwurovM3qeBnE7Q4imFp2F7sz59sb/Q0/uFt/jmrnjcEcNKx7eEZceWQu
HiTTh3/t4b/rx+9DnHuIr3oQfSy3SyCIPWs6MzKg7e45FqI8VzEGjnaJPTzxdF3AHLetaRRBaJOC
YHBxJmb41pNOnqz7+hums6XBCbzxeYJ8g86aCNYuO5y5OrxxG4C4bvfJNb+pooV/8Gj6BnozEyXM
MJ8PloW6ietPl1/hOaWTCnyKxE2U40NF+8anlVkqzUOG2v7Kp6cu/S814OsJkqbKlYSgChKZRmik
pshq8W7Si1eRBDx36o+Pd9GPt6LREXjSVNaDt4VfaeRs0R6H90n3MgJzVS/EpW5stgIUolCCr92y
goZufSa2CUqKnssSj5dsBuwFVXzkJ2QUL1nGXjC84Sx29YUi3iQa/uYAoJC31hS9JGJNQreeiMQ6
6YW+EXNpLjZ7AZbY+lXQA1fonZsg4HNZwjZZqSRLM1lW4vP81fW71cXijeOFdHnBwyvm8lWUFdTy
RPFUR/ledOPNpLFuSbiwHVMFw1S/kLVa1wEiRjfQC9wsVR1/uizSWTSrZqtZOctmI12ZMOHjuS1X
JZ2jbOZ30vWAs1sE2U0fxLZ36U7RAsZUrPSJlgdJV5MOG00xNhS7l8FHveCVAXcPVrdIYI/WegjV
htDm7XQ/59Ld+sOM+zmufN19+6v4yuA71/zHvZCppyT9MwEo30mz1nz6OWQGz/tBAFXyh9AKg+bc
yPcLdmlVYK/4+0E/GVDv6r8f9sbxIf0bhC6gTo8zg7I0KG7Z6R4o8YxuJIVZ1+n0Hmq/qYhOxVzV
SwFJFzp9AZn1VpaQmNYyxjRgru867H3ebmOJa4OeGLGF3FzKOAcixs+My7a3YK0HB+3zlnJ9OvRJ
Ob3FFnhOgFnCuQgeArfdaF3S06Djp7qFeUZR0F65OjeFdO+K3/vuXfWtX99ABP5bzbg8EKuxW7Zh
Nrr4UmAp5hPlcf6rGLXy4Wfkni6Pm3E1NdXbWwW7smONOEbHMFfpYlMe3roHZ50QdS5cxKF3NTC1
2jUjW2u1F5zp/mVXDnll1q5sxxm9GwHc6NXIBcFNvRAuWVg5dGjSbLsN3iFp0tRUdCenzeDS/r1h
t+o6W6/xsqpbpHvDYzs6dTWMTaC2qd5pZ1nzowT7ypxpbb4xw6yh596aa+j+XxDRvMs/IdIHFvgz
jODj2zdX55cXU/fHHBsQbz9c9QHQsPzwTzf0WHFEE/b/AZLvV3upKAAA

--=-c7hGgCniWnYIwPNEmYLT--

