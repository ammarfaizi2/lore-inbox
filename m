Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279648AbRJ0BFm>; Fri, 26 Oct 2001 21:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279660AbRJ0BFb>; Fri, 26 Oct 2001 21:05:31 -0400
Received: from raven.mail.pas.earthlink.net ([207.217.120.39]:24547 "EHLO
	raven.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S279648AbRJ0BFR>; Fri, 26 Oct 2001 21:05:17 -0400
Date: Fri, 26 Oct 2001 21:04:38 -0400 (EDT)
From: Mark Whitis <whitis@freelabs.com>
To: <volodya@mindspring.com>
cc: <livid-gatos@linuxvideo.org>, <video4linux-list@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [livid-gatos] [RFC] alternative kernel multimedia API
In-Reply-To: <Pine.LNX.4.20.0110251258510.8566-200000@node2.localnet.net>
Message-ID: <Pine.LNX.4.33.0110261322410.5502-100000@cervantes.freelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Oct 2001 volodya@mindspring.com wrote:
>  After looking at and working with Xv, v4l and v4l2 I became somewhat
> dissatisfied with the current state of affairs. I have attached a
> description of the API that would make (at least) me much happier.

I have some experience relevent to designing such protocols including:
  - Development of a couple loadable kernel modules
  - Development of a symbol table based parsing system
  - Development of communications protocols
  - parsing of ascii symbolic parameters in a kernel module.
  - Development of a real time full frame rate video capture
    application, though not on linux (it was a telescope
    autoguider (star tracker) which used a $1500 scientific
    frame grabber memory mapped into extended memory on
    a 286 cpu (access to memory was a real bitch).
I do not, however, know a lot about the specifics of the V4l/v4l2/xv
implementations.  So, some of my comments will betray my ignorance
of v4l2 specifics.

First, I definitely agree that passing control information symbolically
rathern than in fixed structs is a good idea in the long run if it is done
as a standard and not just ATI specific.  To qualify as a suitable
successor for existing standards, the new standard must be well designed
and offer as much advantage as possible and as much compatibility with old
standards.  Ascii symbolic "name=value" representations are much more
flexible in supporting a variety of devices and in allowing standards to
evolve without breaking older software and the parsing overhead is quite
reasonable (it is even possible to add negotiation for a tokenized binary
transfer format if you are really paranoid about speed).

I also agree with the one control file per device plus data
transfer file.

Compatibility with older standards could probably be implemented
as a module which accepts old calls and translates them to
new calls.  This would allow old apps to work with new
protocol drivers.

I agree with the person who commented that each command should have a
request id.  This field (say up to 8 characters [A-Za-z0-9_]) will
be repeated on any responses.  This value of this field may not
necessarily be unique; the application could, for example, repeat
"foo" for each command (this is handy for simple apps,  manual
testing, and scripts).

More than one device should be able to open the control interface
simultaneously.   For example, a volume/brightness control app
might be separate from a capture app.

Commands should use FTP style response codes, including the
3 digit response (or 4 digit as used in some varients) with
a hierarchical interpretation of the digits and the trailing
"-" for continuation messages.

1xxx Positive Preliminary reply
2xxx Positive Completion reply
3xxx Positive Intermediate reply
4xxx Transiet Negative Completion Reply
5xxx Permanent Negative Completion Reply

x0xx Syntax error
x1xx Information
x2xx Connections
x3xx Authentiaction and accounting
x4xx unspecified
x5xx file system  - perhaps results pertaining to the hardware


Personally, I would limit to one query or assignment per line.
This allows for simpler parsing and errors can be properly associated
with the actual value being set.

There must be a standardized parameter set.
   video.source
   video.norm
   video.tuner.channel
   video.tuner.freqtable
   video.brightness
   video.contrast
   video.gamma
   video.width
   video.height
   video.nframes
   video.deinterlacemode
   video.format.planes              (1 for interleaved color, 3 for
                                    interleaved color)
   video.format.colorencoding       (Greyscale, YUV, RGB, YUV42)
   video.format.bytesperpix
   audio.volume
   audio.balance
   ...
These need to be the same for all devices.  As new commands are
added for each driver, they can be defined in a central place
so new drivers will use newer commands.

You asked if it was appropriate to bloat the driver with parsing
functions.   It would be best if the parsing functions were
in a separate kernal module rather than duplicated in each
video driver as well as other types of drivers entirely.
Each driver would have one or more symbol tables which
defined the symbols availble.  I have some general purpose parsing
code that has not been adapted to kernel space yet:
   http://www.freelabs.com/~whitis/software/symbol/
These routines can be used for:
   - TCP/IP communications protocols
   - configuration files
   - data save/load
   - handling user commands affecting internal data structures
   - communication with kernel modules (once a kernel version
     is implemented).
Kernel porting would not be too hard:
   - no malloc problems - caller allocates memory.
   -  redefining printf()
   - supplying a few string handling functions not present in kernel space
   - adding module_init() and module_cleanup() functions
   - substituting the appropriate #includes for kernel space.
   - adding protocol encapsulation for the protocol described here
   - adding bit field and enumerated field support
   - simple array support for gamma tables and the like.
I could probably be persuaded to port this library to kernel space for
this purpose.

Functionality can be divided over various modules:
insmod symbol      - symbol table based parsing
insmod vvl3        - new protocol common functions
insmod v4lcompat   - comnvert v4l calls into v4l3 calls
                     may not be needed if translation with
                     the existing translator works with v4l2compat.
insmod v4l2compat  - convert v4l2 calls into v4l3 calls and vice versa
insmod v4lcompress - video compression (optional).
insmod atiaiw      - functions common to all/most ati devices
insmod atiaiw32    - functions specific to a particular card
insmod vbidecode   - vertical blanking decoder
insmod netaccess   - communicates with user space daemon to access
                     video streams over TCP/IP using teleconferncing
                     and streaming protocols and access to other
                     devices with userspace drivers.

There should be four or five types of instructions, not just two:
   - set value
   - query value
   - execute command
   - query symbol tables
     This would allow an application to add dialog box entries
     for each symbol defined by a driver, similar to SANE.
     An application may want to devise
   - kill background process (or current command).

Here is an example.  Commands sent are marked with ">>>" and responses
with "<<<"
>>> foo101 call reset()
<<< foo101 2000 ok
>>> foo102 query video.norm
<<< foo102 2100 video.norm="NTSC"
>>> foo103 query video.source
<<< foo103 2101 video.source="TUNER"
>>> foo104 query video.tuner.channel
<<< foo105 2101 video.tuner.channel
>>> foo106 set video.width=640
<<< foo106 2000 ok
>>> foo107 set video.height=480
<<< foo107 2000 ok
>>> foo108 async call capture(
     note: async keyword means keep processing commands without
     completing this one.
>>>    nframes=16
>>>    vsync=1
>>>    report_frames=1
>>>    start_timecode="00:00:00:00"
>>> )
<<< foo108 1100- Capture Started
>>> foo108 1101- set capturestatus.framenumber=0
>>> foo108 1101- set capturestatus.framenumber=1
>>> foo108 1101- set capturestatus.framenumber=2
>>> foo108 1101- set capturestatus.framenumber=3
>>> foo108 1101- set capturestatus.framenumber=4
>>> foo108 1101- set capturestatus.framenumber=5
>>> foo109 call abort()               // interrupt capture
      note: we now have two outstanding commands
>>> foo109 2000 ok
      note: we are receiving responses now for two outstanding commands
>>> foo108 5500 capture aborted
      note: foo108 must send a final response with no trailing "-"
<<< foo110 query capturestatus
>>> foo110 1100- capturestatus={
<<< foo110 1100-   status="STOPPED"
<<< foo110 1100-   framenumber=5
<<< foo110 1100-   bytestransfered=1000000
<<< foo110 2100 }


If there are too many outstanding commands for internal buffering,
there driver should block the application, unless it uses non-blocking
I/O.  Preferably, no single application should be allowed to use all of
the buffers.


/devfs/multimedia/devices should also be symbolic, not fixed field.  It
makes no sense to fix the problem in one place and reintroduce it
somewhere else.
  {
     device_id="101"
     location_id="PCI:01:00.0"
     ...
  },{
     device_id="102"
     location_id="USB:004/004"
     ...
  }
or more crudely, you can have only one line per device but that will get
very ugly as the number of fields increases.

I don't care much for the idea of Xfont style matching taken that
literally.  Among other things, the "-" character is a very poor choice of
separator as it often occurs in negative numbers, device names, company
names, etc.
Also, consistency with the format already used within a device family is
more important than consistency between device family.  The begining
of the name might be treated in a URLish manner.
   PCI:01:00.0
   USB:001/001
   FIREWIRE:...                           /* DV camcorder or other FW dev */
   SANE://host.example.com:port/          /* scanner */
   DIGICAM:...                            /* pocket Digital camera */
   H323://host.example.com:port/          /* teleconferencing */
   CUCME://host.example.com:port/         /* teleconferencing */
   V4LREMOTE://host.example.com:port/     /* some v4l specific protocol */
   SHOUTCAST://host.example.com:port/     /* shoutcast stream */
Note that some of these need to communicate with a userspace daemon
which does TCP/IP and format translation.  A small kernel module
whould essentially connect a v4l input and a v4l output device.

Note that the v4l device specifier should be either a URL or a filename
in /devfs space.  There will not be a entry in the filesystem for
every possible video source.

Instead, For scripts, a small application could be written that does
pattern matching and data extraction.  The functions used by that app could
also be made availible as a library.  These functions and helper
app could do much more inteligent device selection including
search path and multiple field selection, symbolic links, consulting
system wide and user specific .rc files, environment variables, and
user specified options.

Applicatins should be able to lock/unlock the device for exclusive use
which may not preclude minor control access from control only applications
like xmixer or a remote control receiver.  So, there might be
exclusive capture access and exclusive control access.  Applications
should not use exclusive mode unless configured to do so.  It is
entirely reasonable to interupt a web capture or teleconference
in progress with a snapshot taken for some application.  For
example, I may want to photograph something to sell on ebay
while I am video chatting with my girlfriend.   There are some
applications that may want to capture continously.

The data at the begining of each frame should not be a fixed
struct.  We are trying to get away from fixed structs, remember.
Instead, it should be a sequence of declarations in the form
name=value.    For a crude example of an image format that
does this in real life, look at FITS.

   format=V4L3
   videooffset=1024
   audiooffset=123456


The timestamp at the beginning of each frame of data should
contain a sequence number in two formats: sequential frame
number and relative and absolute SMPTE time code.  Absolute SMPTE
timecodes should be generated sequentially if not timecode source
is detected but if there is a timecode, the absolute code should track
the timecode souce.

The device specific loadable kernel module should make heavy use
of jump tables (structures of function pointers) to call individual
routines which start initialized to general purpose functions
and can be replaced with more device specific functions.


Complicated but general things like video data format conversion may be
handled by a general purpose routine which may "compile" down to
a state machine that does the copying or select from one of
many function pointers to a function which does the approriate
translations.  You could have a small array of tokens which mean things
like:
   loop 640 times
      byteswap
      yuv42toyuv24       (two bytes/pix to 3 bytes/pix)
      rgbtoyuv
   endloop
These tokens could be interpretted inside a large loop with jumps
rather than function calls (for less overhead).  Or the functions
can be done a scanline at a time for less overhead:
   byteswap 640 pixels
   yuv42toyuv24 640 pixels
   rgbtoyuv 640 pixels

By doing a scan line at a time, you assume that the application will
access the data in row-major vs. column-major order.  This assumption
is likely to be true for most bulk transfers.    Similarly,
you can convert one sectors worth of data at a time which is likely
to include portions of one or more scan lines which are converted
as many pixels as are needed.  page tables for the mmaped region
are adjusted to point to the buffer containing the translated data
with all other pages set to generate a page fault which will invoke
the translation routine.

Each driver should allow a few different optimized formats with
some other formats also being optionally availible:
   - raw pixel data
     (this allows mmap directly into frame buffer)
     driver tells application how the data is organized so it
     can decode.
   - 32 bit/2 pixel YUYV
        Y byte(pixel n), U byte , Y byte (pixel n+1), V bytes
   - 24 bit RGB    red byte, green byte, blue byte
   - 24 bit YUV    Y byte, U byte, V byte
   - some optional formats:
      - 48 bit RGB
      - 24 bit CMYK
      - 48 bit CMYK
      - mpeg encoded
      - partially mpeg encoded
      - jpeg encoded
      - MJPEG encoded
      - 16 bit YUV    Y byte, UV byte (with specific order of bits)
                loss of color information vs. YUYV
      - Mixed video and audio
For those formats above, data is in row major order with each
color byte for the first pixel of the first line followed by the
second pixel for the first line, etc.  with no padding between
lines.

The mpeg/jpeg/mjpeg encoded formats are intended for hardware
which support full or partial encoding in hardware and there
would probably need to be an assortment of them, perhaps

The raw format is primarly there for fastest transfers to userspace
with the data possibly being encoded later.   Basically a capture
to userspace RAM.  (25KMB or ram could store about 14 seconds
of 30 fps 640x480 16 bit YUV data).   The other three formats
give the application a choice of a few standard formats
which must be supported by all drivers with a reasonable
degree of efficiency.

Video data formats could be described using a sequence of variables:
videoformat.bytesperline=1280
videoformat.planes=1           (color data interleved)
videoformat.pixelspergroup=2   (either 1 or 2)
   note: this has to do with the peculiarities of typical cameras
   which have twice as many pixels for luminence as for each chrominance
   component.
videoformat.nbytes=4
videoformat.byte00="Y0"
videoformat.byte01="Y1"
videoformat.byte02="U"
videoformat.byte03="V"
videoformat.width=640
videoformat.height=480
videoformat.order="ROWMAJOR"
videoformat.pixelpadding=0   (might be 1 for 24/32 bit RGB)
videoformat.rowpadding=0
videoformat.interlace=0
   note: if 1, this indicates that all odd rows are stored before all
   even rows.
videoformat.audio.bytesperscanline=0
videoformat.audio.bytesperframe=0
videoformat.prefixbytes=0
videoformat.suffixbytes=0
videoformat.timecode.present=0
videoformat.timecode.offset=0
videoformat.timecode.format="SMPTE_ASCII"

Note that the existing v4l2 standards already define video
formats and names for things which should generally be used instead of my
specifications.

VBI (Closed captioning) interface could use a separate
device as is currently done although an option might be to
do it via the control interface (either on the same
connection as the main control connection or from
a separate non-video-capturing application).
   foo110 set vbi.
   foo111 async call VBI()
   foo111 1102- VBI: Closed captioning provided by a grand from
   foo111 1102- VBI: linux international.   Dateline 29 news.
   foo111 1102- VBI: The news you need when you need it.
   foo111 1102- VBI: Tonight on Dateline 29 news...
   foo112 call abort_vbi();
   foo112 2000 ok
   foo111 5502 VBI terminated


The abort functions might be replaced with a new protocol command
"kill" which when used with the command sequence ID of the command
calls the corresponding kill function automatically.

Note that the new standard should define some way to synchronize
the audio and video streams for proper mpeg encoding in userspace.
One way to do this is to append the audio and a sample count
which may vary to the end of each frame of video.  This clearly
identifies which audio samples were taken at the same time
the frame was (give or take a little skew between audio codecs
and video circuitry).  Another is to include time codes in both
the audio and video streams.

Note that to make the protocol easier to implement, we can be
somewhat pedantic out formats in the first version and relax
later if desired:
   - structures and function/proceedure calls will be listed one
     element per line.
   - separators between lines
   - case insensitive matching
   - Strings in double quotes.
   - whitespace allowed at the begining of the line for indentation
     but extranious white space not allowed around "=", "(", "{", etc.

/devfs organization:
   better to organize by device:
      /devfs/multimedia/dev1/control
      /devfs/multimedia/dev1/data
      /devfs/multimedia/dev2/control
      /devfs/multimedia/dev2/data
   This works much better with symbolic links.
      /dev/videocapture -> /devfs/multimedia/dev1
      ~/.v4l/searchpath/
          01 -> /devfs/multimedia/dev10
          02 -> /devfs/multimedia/dev23
          03 -> /devfs/multimedia/dev10


-- 
--
Mark Whitis   http://www.freelabs.com/~whitis/       NO SPAM
Author of many open source software packages.
Coauthor: Linux Programming Unleashed (1st Edition)


