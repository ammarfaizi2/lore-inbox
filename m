Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264881AbUEKRKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264881AbUEKRKY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 13:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264886AbUEKRJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 13:09:22 -0400
Received: from cs.bu.edu ([128.197.12.2]:3071 "EHLO cs.bu.edu")
	by vger.kernel.org with ESMTP id S264881AbUEKRHZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 13:07:25 -0400
Date: Tue, 11 May 2004 13:06:56 -0400
From: Gary Wong <gtw@cs.bu.edu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       herbert@gondor.apana.org.au
Subject: [PATCH] Re: Segmentation fault in i810_audio.c:__i810_update_lvi
Message-ID: <20040511130656.A28363@cs.bu.edu>
References: <20040510123607.T9078@cs.bu.edu> <20040511002728.46e05e4c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040511002728.46e05e4c.akpm@osdl.org>; from akpm@osdl.org on Tue, May 11, 2004 at 12:27:28AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 11, 2004 at 12:27:28AM -0700, Andrew Morton wrote:
> Gary Wong <gtw@cs.bu.edu> wrote:
> > I believe that one of two fixes should be applied: either the
> >  SNDCTL_DSP_SETTRIGGER ioctl handling should not enable the
> >  PCM_ENABLE_{IN,OUT}PUT bits unless file->f_mode is compatible,
> >  or i810_release() should ignore the PCM_ENABLE_* bits without
> >  the corresponding FMODE_*.
> 
> The first option sounds more appropriate but I wonder if it could break
> existing applications?  Probably not, if it oopses.

I agree; I had a look at a few other drivers at random (audio, esssolo1,
trident) and they all silently ignore inappropriate PCM_ENABLE_* bits.

> Let's try option #1, please.

OK, a patch is attached.  It seems to fix the problem on a 2.6.3 system
with Herbert Xu's patches from Jeff Garzik applied.

break-i810.c is a small test case which hopefully demonstrates the
problem.

Cheers,
Gary.
-- 
     Gary Wong          gtw@cs.bu.edu          http://cs-people.bu.edu/gtw/

--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=i810-settrigger-patch

--- i810_audio.c.herbert	2004-05-11 12:36:05.674715334 -0400
+++ i810_audio.c	2004-05-11 12:41:50.101624990 -0400
@@ -2186,6 +2186,10 @@
 #if defined(DEBUG) || defined(DEBUG_MMAP)
 		printk("SNDCTL_DSP_SETTRIGGER 0x%x\n", val);
 #endif
+		if (!(file->f_mode & FMODE_READ ))
+			val &= ~PCM_ENABLE_INPUT;
+		if (!(file->f_mode & FMODE_WRITE ))
+			val &= ~PCM_ENABLE_OUTPUT;
 		if((file->f_mode & FMODE_READ) && !(val & PCM_ENABLE_INPUT) && dmabuf->enable == ADC_RUNNING) {
 			stop_adc(state);
 		}
@@ -2193,7 +2197,7 @@
 			stop_dac(state);
 		}
 		dmabuf->trigger = val;
-		if((file->f_mode & FMODE_WRITE) && (val & PCM_ENABLE_OUTPUT) && !(dmabuf->enable & DAC_RUNNING)) {
+		if((val & PCM_ENABLE_OUTPUT) && !(dmabuf->enable & DAC_RUNNING)) {
 			if (!dmabuf->write_channel) {
 				dmabuf->ready = 0;
 				dmabuf->write_channel = state->card->alloc_pcm_channel(state->card);
@@ -2214,7 +2218,7 @@
 			i810_update_lvi(state, 0);
 			start_dac(state);
 		}
-		if((file->f_mode & FMODE_READ) && (val & PCM_ENABLE_INPUT) && !(dmabuf->enable & ADC_RUNNING)) {
+		if((val & PCM_ENABLE_INPUT) && !(dmabuf->enable & ADC_RUNNING)) {
 			if (!dmabuf->read_channel) {
 				dmabuf->ready = 0;
 				dmabuf->read_channel = state->card->alloc_rec_pcm_channel(state->card);

--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="break-i810.c"

#include <fcntl.h>
#include <sys/ioctl.h>
#include <sys/soundcard.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

extern int main( void ) {

#define DSP "/dev/dsp"
    
    int f = open( DSP, O_RDONLY );
    int i, n;
    fd_set fds;
    
    if( f < 0 ) {
	perror( DSP );

	return EXIT_FAILURE;
    }

    n = 0;
    if( ioctl( f, SNDCTL_DSP_SETTRIGGER, &n ) < 0 ) {
	perror( "SNDCTL_DSP_SETTRIGGER" );

	return EXIT_FAILURE;
    }

    n = PCM_ENABLE_INPUT | PCM_ENABLE_OUTPUT;
    if( ioctl( f, SNDCTL_DSP_SETTRIGGER, &n ) < 0 ) {
	perror( "SNDCTL_DSP_SETTRIGGER" );

	return EXIT_FAILURE;
    }

    for( i = 0; i < 10; i++ ) {
	char a[ 1024 ];
	
	FD_ZERO( &fds );
	FD_SET( f, &fds );

	if( select( f + 1, &fds, NULL, NULL, NULL ) < 0 )
	    perror( "select" );
	
	if( read( f, a, 1024 ) < 0 )
	    perror( "read" );
    }
    
    close( f );

    return EXIT_SUCCESS;
}

--3MwIy2ne0vdjdPXF--
