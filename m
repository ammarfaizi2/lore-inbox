Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263744AbREYNXS>; Fri, 25 May 2001 09:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263745AbREYNW6>; Fri, 25 May 2001 09:22:58 -0400
Received: from qn-212-127-144-62.quicknet.nl ([212.127.144.62]:45061 "HELO
	smcc.demon.nl") by vger.kernel.org with SMTP id <S263744AbREYNWr>;
	Fri, 25 May 2001 09:22:47 -0400
Message-ID: <XFMail.010525152244.nemosoft@smcc.demon.nl>
X-Mailer: XFMail 1.3 [p0] on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20010525131502.I12364@arthur.ubicom.tudelft.nl>
Date: Fri, 25 May 2001 15:22:44 +0200 (MEST)
Organization: I'm not organized
From: "Nemosoft Unv." <nemosoft@smcc.demon.nl>
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
Subject: Re: ac15 and 2.4.5-pre6, pwc format conversion
Cc: linux-kernel@vger.kernel.org, Norbert Preining <preining@logic.at>,
        linux-usb-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

On 25-May-01 Erik Mouw wrote:
> On Fri, May 25, 2001 at 10:48:12AM +0200, Nemosoft Unv. wrote:
>> That´s what you get for ripping out the guts of a driver. Have a nice
>> day.
> 
> The format conversion shouldn't be there in the first place. Format
> conversion is policy, so it doesn't belong in kernel. Note for example
> that none of the sound drivers does sample rate conversion although
> some sound chips are locked at 48kHz only.

True, but a number of audio tools will break, because they don´t support that
samplerate (mpg123 0.59r, one of the more popular MP3 players, segfaults
when it has to do conversion of 44.1 KHz to 48 KHz). Recording from such a
source is usually less of a problem, although some post-processing is
then necessary (not all tools support samplerate conversion natively).

The situation for video devices is worse. 80% of the video tools will break
if you limit the number of available palettes per driver. Plus, you will get
severe fragmentation of which program works with which driver. Which is
unacceptable, in my opinion (and certainly NOT the idea behind a common API!)

You can blame the authors of those video tools, but that´s not really fair.
The original Video4Linux API was based upon TV grabber cards. Most of them
do YUV/RGB conversion in hardware, so most tools expected that all or most
palettes would always be available, since supporting a palette would not
require any extra CPU cycles [1]. Some tools like RGB, and others YUV, so
the authors happily selected the palette of their choice and never even
considered building in functions for doing conversion. And then I am not even
talking about the RGB/BGR mess.

Then along came parallel-port and USB webcams, which have a number of
´native´ formats which only sometimes match the defined V4L palettes. So
some conversion, albeit trivial, is necessary. Might as well do the full
conversion to various YUV/RGB palettes then, to accomodate as much programs
as possible (granted, some tools are really braindead).

Which is exactly what I did, and therefor I was quite sarcastic in my
previous mail because my driver was targeted for removal of ALL conversion
routines, while (nearly) nothing has been said about other (USB) webcam
drivers which have conversion routines.

Johannes Erdfeld (current USB maintainer) said he would go over the other
USB drivers and see which ones are eligeble for removal of YUV->RGB
conversion (which are, btw: ov511 and cpia; ibmcam flatly refuses anything
except RGB24). I warned him that if he does so, he will get a lot of angry
looks from users.

I do agree that the kernel may not be the proper place for these kind of
conversions. But as I wrote to Alan Cox earlier today that if he wanted to
fix this, he should fix the problem, which are ´simplistic´ programs and a
hardware specific API (V4L1, and V4L2 isn´t that much better), and not
target the drivers. But it will take something really radical (like removing
the V4L API altogether), that will wake up the authors of ALL video
tools and ´fix´ their programs. Alan Cox certainly isn´t going to do that
himself, and neither am I :)

In other words: if you want to break it, break it well. Don´t smash the
saucer without the cup.

 - Nemosoft


[1] There´s an additional problem, which has plagued my driver for quite
some time: TV cards can scale the image to any size, again in hardware. For
webcams which only have a few fixed sizes, some padding or cropping may be
required (this can usually be programmed very easily, and requires only a few
extra CPU cycles). Scaling on the fly is definitely out of the question, even
for me.

-----------------------------------------------------------------------------
Try SorceryNet!   One of the best IRC-networks around!   irc.sorcery.net:9000
URL: never        IRC: nemosoft      IscaBBS (bbs.isca.uiowa.edu): Nemosoft
                        >> Never mind the daylight << 
