Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312169AbSDNLeS>; Sun, 14 Apr 2002 07:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312178AbSDNLeR>; Sun, 14 Apr 2002 07:34:17 -0400
Received: from ppp-225-71-155.friaco.access.uk.tiscali.com ([80.225.71.155]:260
	"EHLO hoffman.vilain.net") by vger.kernel.org with ESMTP
	id <S312169AbSDNLeP>; Sun, 14 Apr 2002 07:34:15 -0400
Date: Sun, 14 Apr 2002 12:14:29 +0100
From: Sam Vilain <sv@easyspace.com>
To: t.sailer@alumni.ethz.ch
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: USB audio device - ABIT UA11 dual toslink I/O
Message-Id: <20020414121429.45112a14.sv@easyspace.com>
In-Reply-To: <3CB337B4.EE569F52@scs.ch>
Organization: Easyspace Ltd
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
X-Face: PI2{lKxF*i|]%@A&-0AV/%sXN)UJ<+SeG}%8Cn%**KZ[f_OSx{xw&Rstfu?!x^ZJ%LV@4Z% Zr"EZm.GQFy@;"V82_:?cJ`kQ3+
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Sailer <sailer@scs.ch> wrote:

> > usbaudio: unit 8: invalid PROCESSING_UNIT descriptor
> Aparently this is due to a superfluous test in the audiocontrol
> parsing...

Would that be this test:

    case PROCESSING_UNIT:
	if (   p1[0] <  13
	   ||  p1[0] <   13 + p1[6] 
	   ||  p1[0] < 	  13 + p1[6] + p1[ 11 + p1[6] ]
	   ||  p1[0] <     13 + p1[6] + p1[ 11 + p1[6] ]
		      + p1[ 13 + p1[6] + p1[ 11 + p1[6] ] ] )
	{                       
	    printk(KERN_ERR "usbaudio: unit %u: invalid PROCESSING_UNIT"
		   "descriptor\n", unitid);
	    return;
        }
        usb_audio_processingunit(state, p1);
        return;

This relates to this section of `lsusb':

      AudioControl Interface Descriptor:
        bLength                16
        bDescriptorType        36
        bDescriptorSubtype      7 (PROCESSING_UNIT)
        bUnitID                 8
        wProcessType            3
        bNrPins                 1
        baSourceID( 0)          7
        bNrChannels             2
        wChannelConfig     0x0003
          Left Front (L)
          Right Front (R)
        iChannelNames           0 
        bControlSize            2
        bmControls( 0)       0x03
        bmControls( 1)       0x00
          Enable Processing
        iProcessing             0 
        Process-Specific    

I removed the last one of those || tests, because it was the only
figure that amounted to greater than p1[0] - it was 25, p1[0] was 16.

here's the messages out now (I changed a few #ifdef 0's to 1, so
there's a bit more debugging output, and added one on
usb_audio_recurseunit so I could see it being run):

usb.c: registered new driver audio
usbaudio: device 5 audiocontrol interface 0 has 1 input and 1 output AudioStream
ing interfaces
usbaudio: valid input sample rate 48000
usbaudio: valid input sample rate 32000
usbaudio: valid input sample rate 44100
usbaudio: device 5 interface 2 altsetting 1: format 0x00000010 sratelo 32000 sra
tehi 48000 attributes 0x01
usbaudio: valid input sample rate 48000
usbaudio: valid input sample rate 32000
usbaudio: valid input sample rate 44100
usbaudio: device 5 interface 2 altsetting 2: format 0x80000010 sratelo 32000 sra
tehi 48000 attributes 0x01
usbaudio: device 5 interface 1 altsetting 0 does not have an endpoint
usbaudio: valid output sample rate 48000
usbaudio: valid output sample rate 32000
usbaudio: valid output sample rate 44100
usbaudio: device 5 interface 1 altsetting 1: format 0x00000010 sratelo 32000 sra
tehi 48000 attributes 0x01
usbaudio: valid output sample rate 48000
usbaudio: valid output sample rate 32000
usbaudio: valid output sample rate 44100
usbaudio: device 5 interface 1 altsetting 2: format 0x80000010 sratelo 32000 sra
tehi 48000 attributes 0x01
usbaudio: registered dsp 14,19
usbaudio: constructing mixer for Terminal 10 type 0x0301
usbaudio: usb_audio_recurseunit(struct consmixstate *state,9)
usbaudio: usb_audio_recurseunit(struct consmixstate *state,8)
usbaudio: usb_audio_recurseunit(struct consmixstate *state,7)
usbaudio: usb_audio_recurseunit(struct consmixstate *state,4)
usbaudio: usb_audio_recurseunit(struct consmixstate *state,1)
usbaudio: usb_audio_recurseunit(struct consmixstate *state,5)
usbaudio: usb_audio_recurseunit(struct consmixstate *state,2)
usbaudio: usb_audio_recurseunit(struct consmixstate *state,6)
usbaudio: usb_audio_recurseunit(struct consmixstate *state,3)
usbaudio: warning: found 1 of 0 logical channels.
usbaudio: assuming the channel found is the master channel (got a Philips camera
?). Should be fine.
usbaudio: unit 7 invalid MIXER_UNIT descriptor (bitmap too small)
usbaudio: registered mixer 14,16
usbaudio: constructing mixer for Terminal 13 type 0x0101
usbaudio: usb_audio_recurseunit(struct consmixstate *state,12)
usbaudio: usb_audio_recurseunit(struct consmixstate *state,11)
usbaudio: usb_audio_recurseunit(struct consmixstate *state,2)
usbaudio: selector unit 11: ignoring channel 1
usbaudio: usb_audio_recurseunit(struct consmixstate *state,3)
usbaudio: selector unit 11: input pins with varying channel numbers
usbaudio: feature unit 12 source has no channels
usbaudio: no mixer controls found for Terminal 13
usb_audio_parsecontrol: usb_audio_state at ce0b1760
audio.c: v1.0.0:USB Audio Class driver

Sox says something different now:

hoffman:~/sounds/tech_samps/reference$ strace -fo /tmp/trace play -d /dev/dsp1 trumpets1.wav 
Process 4885 attached
Process 4884 suspended
Process 4884 resumed
Process 4885 detached
Process 4886 attached
Process 4886 detached
Process 4887 attached
Process 4884 suspended
sox: Unable to set audio speed to 44100 (set to 524288)
Process 4884 resumed
Process 4887 detached

Here's the trace:
4887  open("/dev/dsp1", O_WRONLY|O_CREAT|O_TRUNC, 0666) = 4
4887  fstat64(4, {st_mode=S_IFCHR|0660, st_rdev=makedev(14, 19), ...}) = 0
4887  ioctl(4, SNDCTL_TMR_TIMEBASE, 0xbffff9b8) = -1 ENOIOCTLCMD (errno 515)
4887  old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
0) = 0x40017000
4887  fstat64(4, {st_mode=S_IFCHR|0660, st_rdev=makedev(14, 19), ...}) = 0
4887  ioctl(4, SNDCTL_DSP_RESET, 0)     = 0
4887  ioctl(4, SNDCTL_DSP_SYNC, 0)      = 0
4887  ioctl(4, SNDCTL_DSP_GETFMTS, 0xbffffb14) = 0
4887  ioctl(4, SOUND_PCM_READ_BITS, 0xbffffb14) = 0
4887  ioctl(4, SNDCTL_DSP_STEREO, 0xbffffb14) = 0
4887  ioctl(4, SOUND_PCM_READ_RATE, 0xbffffb14) = 0
4887  write(2, "sox: ", 5)              = 5
4887  write(2, "Unable to set audio speed to 441"..., 50) = 50
4887  write(2, "\n", 1)                 = 1
4887  ioctl(4, SNDCTL_DSP_GETBLKSIZE, 0x80a52f0) = 0
4887  brk(0x80ae000)                    = 0x80ae000
4887  munmap(0x40017000, 4096)          = 0
4887  brk(0x80b4000)                    = 0x80b4000
4887  brk(0x80ba000)                    = 0x80ba000
4887  brk(0x80cb000)                    = 0x80cb000
4887  brk(0x80d1000)                    = 0x80d1000
4887  brk(0x80e2000)                    = 0x80e2000
4887  brk(0x80eb000)                    = 0x80eb000
4887  brk(0x80f4000)                    = 0x80f4000
4887  read(3, "\31\0\345\377\31\0\326\377\16\0\313\377#\0\306\377\23\0"..., 8192
) = 8192
4887  read(3, "\311\371m\375\323\371\326\374\375\371Z\374-\376e\374\r"..., 8192)
 = 8192
4887  write(4, "\31\0\345\377\32\0\344\377\33\0\342\377\34\0\340\377\35"..., 163
84) = 16384
4887  write(4, "\377\377\270\377\377\377\270\377\0\0\270\377\0\0\271\377"..., 16
[...]
4887  write(4, "\374\377\220\377\374\377\217\377\375\377\215\377\375\377"..., 16
384) = 16384
4887  close(3)                          = 0
4887  munmap(0x40016000, 4096)          = 0
4887  write(4, "\25\0\326\377\25\0\326\377\25\0\326\377\25\0\326\377\25"..., 111
2) = 1112
4887  close(4)                          = 0
4887  _exit(0)                          = ?

Something is now coming out of the output, but it sounds like it's
being played with the wrong encoding or something like that.  It's
really broken, but the total level of the sound output is somewhat not
entirely unlike the sound I'm playing.  It also takes longer to play
than it should - something less than twice as long as the audio file,
so I doubt it's really being played with a sampling frequency of
524288 :).  My MD player seems to be happily locked onto its output,
so the device is really running at a sane sampling frequency.

The error about the MIXER_UNIT is probably expected - I don't think
that this device actually _has_ a mixer.  I suspect it's just a dumb
straight-through digital audio interface.

> > [pid  1892] ioctl(4, SNDCTL_DSP_RESET, 0) = 0
> > [pid  1892] ioctl(4, SNDCTL_DSP_SYNC, 0) = 0
> > [pid  1892] ioctl(4, SNDCTL_DSP_GETFMTS, 0xbffffc04) = 0
> > [pid  1892] ioctl(4, SOUND_PCM_READ_BITS, 0xbffffc04) = 0
> > [pid  1892] ioctl(4, SNDCTL_DSP_STEREO, 0xbffffc04) = 0
> > [pid  1892] ioctl(4, SOUND_PCM_READ_RATE, 0xbffffc04) = 0
> > [pid  1892] write(2, "sox: ", 5sox: )        = 5
> > [pid  1892] write(2, "Unable to set audio speed to 441"..., 45Unable
> > to set audio speed to 44100 (set to 0)) = 45
> 
> Spooky. It doesn't even try to set the sampling rate but complains...
> somehow cannot be...

I think it was probably complaining about this error:

[pid  1892] ioctl(4, SNDCTL_TMR_TIMEBASE, 0xbffffaa8) = -1 ENOIOCTLCMD
(errno 515)

it looks to me like it's trying to set the time base of sampler/sampling
period.  It gets an error, so it then falls back to reading what the
sampler is currently running at to see if it just happens to be what we
want.  It reads a period of "0".  Hmm, a wave with a period of 0 ...
that's the sound of one hand clapping isn't it?

> > ioctl(3, SOUND_PCM_READ_BITS, 0xbffffab0) = -1 EINVAL (Invalid
> > argument)
> Again spooky, I don't see how audio.o ioctl handler could return EINVAL
> at that call. EFAULT yes, but EINVAL??

How would I go about debugging that?
--
   Sam Vilain, sam@vilain.net     WWW: http://sam.vilain.net/
    7D74 2A09 B2D3 C30F F78E      GPG: http://sam.vilain.net/sam.asc
    278A A425 30A9 05B5 2F13

  "God is a comedian playing to an audience too afraid to laugh."
 - Voltaire -
