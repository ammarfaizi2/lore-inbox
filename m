Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285783AbSAGTeT>; Mon, 7 Jan 2002 14:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285724AbSAGTeE>; Mon, 7 Jan 2002 14:34:04 -0500
Received: from odin.allegientsystems.com ([208.251.178.227]:28544 "EHLO
	lasn-001.allegientsystems.com") by vger.kernel.org with ESMTP
	id <S285703AbSAGTcp>; Mon, 7 Jan 2002 14:32:45 -0500
Message-ID: <3C39F7CD.8010607@allegientsystems.com>
Date: Mon, 07 Jan 2002 14:32:29 -0500
From: Nathan Bryant <nbryant@allegientsystems.com>
Organization: Allegient Systems
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: Thomas Gschwind <tom@infosys.tuwien.ac.at>
CC: linux-kernel@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: Re: i810_audio
In-Reply-To: <20020105031329.B6158@infosys.tuwien.ac.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gschwind wrote:

>
>+		/* TG: can this possibly be correct? 
>+		 * according to OSS doc, cinfo.blocks should return the
>+		 * number of fragment transitions since the previous call
>+		 * to this ioctl. Shouldn't it be better to set 
>+		 * cinfo.blocks to 0 if we do not support this?
>+		 * Why would we want to update the playback pointer? This
>+		 * is not mentioned in the OSS doc!
>+		 * val==number_free_bytes, hence we increase swptr by val.
>+		 * This means that we set the buffer to full.  It is 
>+		 * likely, however, that the hwptr has increased since the 
>+		 * call to this ioctl, hence part of the buffer is being
>+		 * played twice!
>+		 */
>
It is correct. MMAP mode doesn't work without it, and we only care about 
this IOCTL during mmap mode. I think you'll find that it should have 
been setting blocks correctly in mmap mode, the api sequence look like 
this (pseudocode:)

open("/dev/dsp");
mmap(...);
// apps that use mmap mode (only Quake* AFAIK, maybe some other games) 
will write zeroes to fill mmap buffer at this point

ioctl(SNDCTL_DSP_SETTRIGGER, &PCM_ENABLE_OUTPUT); // this updates LVI to 
point to entire 64K buffer and starts DAC. card begins playing silence. 
at this point, dmabuf->count = 64K and begins counting down to zero.

ioctl(SNDCTL_DSP_GETOPTR, &foo); // Quake will call this right before it 
needs to actually start playing sound (several seconds after the initial 
SETTRIGGER call, long enough for the 64K of silence to be played and for 
the DAC to stop with DCH interrupt.) Since the game *needs* to have the 
current output pointer before it can start writing data to be played, we 
take this as a signal that it *intends to do so*, and update the LVI to 
play the next 64K of ring-buffer. Note that the mmap-api spec in OSS 
docs says that the hardware should be set to loop around the ring buffer 
*ad infinitum* in mmap mode, with no further input, so setting it to 
simply play the first 64K--intead of infinity--can't hurt. (We can't 
tell the hardware to loop around the buffer forever since there is no 
command to do so. The only other way to handle that would be to make the 
completition interrupt handlers take care of it, which is more error 
prone in my opinion, interrupts could be missed plus it pays to keep the 
interrupt handlers as simple as possible.) So we rely on the app calling 
GETOPTR often enough to keep the LVI chasing around the buffer - which 
is *has* to do anyway if it wants to play meaningful data. If it stops 
calling GETOPTR, that means it has frozen or slowed down to much to 
handle audio anyway. Neat solution, no? ;-)

Note that, after every call to GETOPTR, dmabuf->count gets set to 64K, 
and the returned value for blocks is based on dmabuf->count, so the 
semantics should actually be correct; we do:

cinfo.blocks = (dmabuf->dmasize - dmabuf->count)/dmabuf->userfragsize;

initially after GETOPTR, count = 64K, so blocks = (64K - 64K) / 
fragsize; ( = 0, correct according to docs)
count winds down to zero, updated by i810_update_ptr: assume next call 
to GETOPTR occurs exactly 64K later:

blocks = (64K - 0) / userfragsize = the number of blocks played since 
last call

so, please put it back the way it was ;)

>
>+#ifndef USE_ORIGINAL_SNDCTL_DSP_GETxPTR_CODE
>+		cinfo.blocks = 0;
>+#else
>+		cinfo.blocks = val/dmabuf->userfragsize;
>+		if (dmabuf->mapped && (dmabuf->trigger & PCM_ENABLE_OUTPUT)) {
>+			dmabuf->count += val;
>+			dmabuf->swptr = (dmabuf->swptr + val) % dmabuf->dmasize;
> 			__i810_update_lvi(state, 0);
> 		}
>+#endif
>


