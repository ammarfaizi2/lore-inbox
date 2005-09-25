Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbVIYWHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbVIYWHI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 18:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbVIYWHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 18:07:08 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:54683 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S932314AbVIYWHH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 18:07:07 -0400
Message-ID: <43371F89.7090704@vc.cvut.cz>
Date: Mon, 26 Sep 2005 00:07:05 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.7.11) Gecko/20050914 Debian/1.7.11-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
CC: LM Sensors <lm-sensors@lm-sensors.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Request only really used I/O ports in w83627hf driver
References: <20050907181415.GA468@vana.vc.cvut.cz>	<20050907210753.3dbad61b.khali@linux-fr.org>	<431F4006.6060901@vc.cvut.cz> <20050925195735.1ef98b40.khali@linux-fr.org>
In-Reply-To: <20050925195735.1ef98b40.khali@linux-fr.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare wrote:
> Hi Petr,
>>No, it would perfectly work.  W83627HF (and all other hardware monitoring
>>chips from Winbond) respond only to xxx5 and xxx6 address, not to the
>>other addresses in the range xxx0-xxx7. So requesting full 8 byte range
>>is not only unnecessary, but also incorrect.
> 
> 
> Incorrect WRT to which specification or coding rules guide, please?

WRT specification.  W836[239]7HF datasheet, W83627THF datasheet and W83627EHF 
datasheet.  Chip responds to the XXX5 and XXX6 address only, where XXX is 
defined by registers 0x60/0x61 in the hardware monitoring function in the 
SuperIO.  And you should not request I/O addresses into which chip does not respond.

>>For example I can place 4-byte printer port at 0xC00-0xC03, while sensors
>>live at 0xC05-0xC06.  If I place sensors and serial port at same address,
                                                ^^^^^^^^^^^
>>I get bytes (from C00-C07) "04 00 01 00 13 40 01 00".  When I move senors
>>away, I get "04 00 01 00 13 06 00 00", so you can see that only address + 5
>>and + 6 are affected.  And when I move serial port away, leaving sensors
>>in place, I see "FF FF FF FF FF 40 01 FF" - again chip respons to +5 & +6
>>addresses only, not to the full range.
> 
> I see a problem with your demonstration. Your 4-byte printer port was
> seemingly affecting not only 0xC00-0xC03, but also 0xC04 and 0xC07. Had
> you tried without sensors in the way, I bet we would have seen ports
> 0xC05 and 0xC06 change values as well. This means that your printer port
> does answer to reads on I/O ports it has no use for. This is exactly
> what I (erroneously) thought would happen with the W83627HF chip.

It was not parallel port, but serial one.  I do not understand your paragraph - 
my demonstration clearly shows that sensors chip answers to C05 and C06 only, 
leaving C00-C04 and C07 with values they have when sensors are not mapped here.

> I'm no electronics expert (far from that actually) but isn't it a
> problem, from an electronic point of view, to have two devices
> competing for I/O ports? What if your printer port were "stronger" than
> your W83627HF? My guess is that the latter wouldn't work anymore.

Yes, that is (actually would be...) problem when 8 byte device is there, like in 
  the test I performed above.  But as you see, contents of C00-C04 & C07 did not 
change, although it "won" on C05/C06.  So you can see chip does not respond to 
C00-C04 & C07.

So I've rerun tests again, this time with real printer port instead of using 
8-byte serial port.

SIO LPT and SENSORS disabled
0C00: FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
SIO LPT at 0C00
0C00: 04 87 CC FF FF FF FF FF FF FF FF FF FF FF FF FF
SIO LPT at 0C00, SENSORS at 0C00
0C00: 04 87 CC FF FF 4F A3 FF FF FF FF FF FF FF FF FF
SIO LPT disabled, SENSORS at 0C00
0C00: FF FF FF FF FF 4F A3 FF FF FF FF FF FF FF FF FF

You can see parallel port affecting C00-C02, and sensors C05-C06.  No conflicts.

> I just checked on an IT8705F Super-I/O with hardware monitoring. It has
> an 8-byte I/O region with +5 and +6 only used, just like the W836x7HF
> family. The device presence changes the I/O region from:
>   ff ff ff ff ff ff ff ff
> to:
>   04 04 04 04 04 51 04 04
> So, the IT8705F definitely answers on the full I/O range, even ports it
> isn't supposed to care about, just like the printer port in your
> example. Same is true of the IT8712F, BTW.

Maybe.  I do not have IT* datasheets.  Also I'm talking about w83627hf.  I just 
added notes about other chips to the bugzilla without verifying their datasheets.

>>It is not buggy BIOS.  It is incorrect assumption of driver writter about
>>hardware, and about request_region API.  If you want to put potential
>>resources to the tree, you should not tag them BUSY, as they are not
>>busy, they are free for use by the driver.
> 
> There are plenty of drivers out there which request more I/O ports than
> they strictly need, just because the author knew that no other driver
> would ever need these. Reasons to do this are multiple: sparse used I/O
> ports (you're not going to call request_region 3 times if you need 3 I/O
> ports spread over a large I/O region), plans to implement more features
> in that driver in the future, anticipation of hardware evolution. You
> really can't blame the driver writer.

See for example parport...  It requests 0x378-0x37A and 0x37B-0x37F separately. 
  And processor_core seems to also request only small part of some larger region 
('ACPI CPU throttle' region).  But ACPI may be different, it just reserves 6 
bytes at some address it somehow computed, so maybe somebody could want other 
bytes of that region - but it does not on my board.

On my boxes rtc & keyboard are drivers which are overallocating their regions. 
But they are always here, and so other drivers know that they should not call 
request region at all (particullary serio knows it should not do request_region, 
as well as kernel & nvram knows to not register 'rtc' (although they use it), as 
rtc driver is one who does request_region).  And fortunately for them 
keyboard/dma... are registered before pnpacpi regions are processed - otherwise 
they would all fail...

> This leads me to the following conclusions:
> 1* Reserving only 0x295-0x296 for the W836x7HF family of chips should
> be safe, if and only if all other drivers do reserve all I/O ports they
> decode, as opposed to only I/O ports they have a use for.

Yes.

> 2* Your printer port above should really reserve the 8 I/O ports it
> decodes, rather than just the 4 it needs. Which driver is this?

Yes.  I did not do tests with parallel port, but with serial port to show that 
even on conflicting devices sensors chip does not affect other addresses (i.e. 
it does not drive other addresses to 0xFF, it just leaves bus floating).

> The bottom line is that I am now inclined to accept your patch. I would
> only ask you for one minor change: please drop the local "addr"
> variable you have been introducing, you can do without it very easily
> and it should make the code more readable.

I'll revert that part of patch completely, just changing request_region.

> I would also want you to check that all of the W83627HF, W83627THF,
> W83697HF and W83637HF chips do not decode ports other than +5 and +6. I
> hope and guess so, but if not we will need slightly more complex code.

I've tested multiple revisions of W83627HF and W83627THF in various Tyan and 
ASUS boards.  I'll perform some search accross my other computers, but I'm not 
aware about any using W83697HF or W83637HF.

Their datasheet has paragraph about LPC interface identical to W83627{HF,THF}, 
but it may be insufficient for you (spec says 'The first interface uses LPC Bus 
to access which ports of low byte (bit2-bit0) are defined in the port 5h and 6h. 
  The other higher bits of these ports is set by W83697HF itself.  The general 
decoded address is set to port 295h and port 296h.'  It is identical for 627HF, 
637HF, 697HF and 627EHF.  For 627THF 'The first interface' is just reworded as 
THF does not have i2c interface.)

> Could you please additionally check whether this applies to the
> W83627EHF/EHG chips as well? Maybe we need to modify the w83627ehf
> driver in a similar way.

I'll try them tomorrow, I know we have boards with this chip, unfortunately they 
run Windows by default, so it will need some preparation.
								Petr

