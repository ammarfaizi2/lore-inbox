Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262008AbVCERUD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbVCERUD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 12:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbVCERS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 12:18:27 -0500
Received: from www.rapidforum.com ([80.237.244.2]:28548 "HELO rapidforum.com")
	by vger.kernel.org with SMTP id S262008AbVCERKg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 12:10:36 -0500
Message-ID: <4229E805.3050105@rapidforum.com>
Date: Sat, 05 Mar 2005 18:10:29 +0100
From: Christian Schmid <webmaster@rapidforum.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a3) Gecko/20040817
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: BUG: Slowdown on 3000 socket-machines tracked down
Content-Type: multipart/mixed;
 boundary="------------070603070208040206040109"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070603070208040206040109
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

After weeks of work, I can now give a detailed report about the bug and when it appears:

Attached is another traffic-image. This one is with 2.6.10 and a 3/1 split, preemtive kernel, so all 
defaults.

The first part is where I throttled the whole thing to 100 MBit in order to build up a traffic-jam ;)

When I released it, it jumped up immediately but suddenly it goes down (each pixel is one second) 
Playing around with min_free_kbytes didnt help. Where it goes up again I set lower_zone_protection 
to 1024000 and where it goes down I set it to 0 again and where it goes up the last time... guess..

This test was with 3500 sockets.

Today I tested with 5000 sockets. The problem is the same like above but the more sockets there 
come, it just doesnt claim more bandwidth as it SHOULD of course do. It seems it doesn't slow down 
but it just doesnt scale anymore. The badwidth doesnt go over 80 MB/Sec, no matter what I do. Then I 
did the following: I raised lower_zone_protection to 1024 (above I did 1024000 which is bullshit but 
it doesnt matter as it seems to just protect the whole low-mem which is what I want) and it was at 
80 MB. then I lowered to 0 again and suddenly it peaked up to full bandwidth (100 MB) for about 5 
seconds until the whole protected area was in use. Then it slowed down drastically again.

My theory:

I suppose when the blocks come in fast enough and the load is high enough, the kernel cant free the 
required low memory as fast as this would be required in order to NOT slow-down everything. So the 
vm is basically busy freeing low-memory. What do you think? The interesting part is that it slows 
down painfully with lower_zone_protection set to 0, it peaks at 80 MB/Sec with lower_zone_protection 
set to max (1024, whole low-mem) and there is much cpu-ressources free..... When set to 0 it speeds 
up without limit AS LONG AS there is memory left. When its consumed, it slows down painfully again 
because its set to 0 of course.

Chris

--------------070603070208040206040109
Content-Type: image/png;
 name="traffic2.png"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="traffic2.png"

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
F4DjNSvJPneH2HhLCF6tuAHGXK3WvnSW25m2wb4eLWDdcOQYANGrvnjYAQAAiRlTE1uru8DK
88cP0+ortmtMAwCAd301sfcCZN/0NaYBnN29B4cAnEZ2VU4AAEBihvYTC8APS934s8R8lrwJ
yQ1NQDIyIdZJVvucxA+6LK3L467/VOcNLKgqhVgAABKTXcOlKJ6S6njVt2RgbbH1F6xfZe0G
Pvrt74n1E/vpk4MOAMDpqYkFACA5amIBAEiOfmIBAEiOfmIBfhbbTT+6pANoURMLgC8pQHKq
MmSWAgD87DVcQgghXMLr+/+bLuH15u/cep10t4H2+uzaFm693rWdpLwsmsMxpvzOrd99X55n
q4mduvCm/u5ruPz0e3PasMZ8lpxfPY/m515yvnvMo2/9xbouU9leuuazxfKAMdtm1zZZH+ua
/7pev/dv6u/1za+vjbeO22OOgWPObbfed439fei85q6Xse/dN9+tjvlLbk9zMtFS++NruIRQ
hfSuxM5d6VsH2bE7+1LtmfKNZ+mw2Lexj23fVkH2VrsE2WnzG7qOYwyyc64YnKE9U9u11BWp
Na927rWct9w/9wiyY+Y/Z/tL7UvwlkE2xf2iVxaUE5zhKoL2HWe52QbP2faj7C+HP6liv7D9
bqcqw+XrH99eQ3YNZVWGa3YNoSqDcePGjRs3bty4ceNRjIdrKEMZriGEMoT38cvXP//3Wr9k
aGhoaGhoaGhoGNXwQ6D9MfWXEMJb4jU0NDQ0NDQ0NDSMbXh9i67X7BrK79UEZRXC5euf317L
6u0H3y7hvk0wbty4cePGjRs3bjym8VCF8FK9hF+zX8PlP79/06EdAABxy0J4Kd8C7Ev1Ev4P
Lmw0yHQGMuQAAAAASUVORK5CYII=
--------------070603070208040206040109--
