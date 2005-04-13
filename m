Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbVDMPrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbVDMPrX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 11:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbVDMPrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 11:47:23 -0400
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:39350 "EHLO
	certainkey.com") by vger.kernel.org with ESMTP id S261379AbVDMPii
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 11:38:38 -0400
Date: Wed, 13 Apr 2005 11:36:40 -0400
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: David McCullough <davidm@snapgear.com>
Cc: johnpol@2ka.mipt.ru, Andrew Morton <akpm@osdl.org>,
       herbert@gondor.apana.org.au, jmorris@redhat.com,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       cryptoapi@lists.logix.cz, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] API for TRNG (2.6.11) [Fortuna]
Message-ID: <20050413153640.GB12263@certainkey.com>
References: <20050315133644.GA25903@beast> <20050324042708.GA2806@beast> <20050323203856.17d650ec.akpm@osdl.org> <1111666903.23532.95.camel@uganda> <42432596.2090709@pobox.com> <1111724759.23532.121.camel@uganda> <42439781.4080007@pobox.com> <20050331035214.GA12181@beast> <20050331135822.GR24697@certainkey.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="oFbHfjnMgUMsrGjO"
Content-Disposition: inline
In-Reply-To: <20050331135822.GR24697@certainkey.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oFbHfjnMgUMsrGjO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Patch attached.

JLC

On Thu, Mar 31, 2005 at 08:58:22AM -0500, Jean-Luc Cooke wrote:
> On Thu, Mar 31, 2005 at 01:52:14PM +1000, David McCullough wrote:
> > 
> > Jivin Jeff Garzik lays it down ...
> > ...
> > > >If kernelspace can assist and driver _knows_ in advance that data
> > > >produced is cryptographically strong, why not allow it directly
> > > >access pools?
> > > 
> > > A kernel driver cannot know in advance that the data from a hardware RNG 
> > > is truly random, unless the data itself is 100% validated beforehand.
> > 
> > You can also say that it cannot know that data written to /dev/random
> > is truly random unless it is also validated ?
> > 
> > For argument you could just run "cat < /dev/hwrandom > /dev/random"
> > instead of using rngd.
> > 
> > If /dev/random demands a level of randomness,  shouldn't it enforce it ?
> > 
> > If the HW is using 2 random sources, a non-linear mixer and a FIPS140
> > post processor before handing you a random number it would be nice to
> > take advantage of that IMO.
> 
> 
> For those who are interested, my Fortuna patch to the Linux RNG (/dev/random,
> /dev/urandom) is available here (2.6.12-rc1, works on kernels as low as
> 2.6.11.4):
>   http://jlcooke.ca/random/
> 
> Fortuna is a Cryptographically Secure Random Number Generator (CSRNG)
> developed by Neils Ferguson and Bruce Schnier and published in their book
> Applied Cryptography.
> 
> By most regards, it is the state of the art as far as software based CSRNGs
> go.  The website gives an over view of the design, here is a summary:
>   Fortuna uses a block cipher (AES128) in CTR mode to generate output.
>   Fortuna uses a 32 hash states (SHA-256) which collect event data from
>   sources of randomness (as usual in Linux).
>   Once every 0.1sec or so, some of the hash states are finalised and the
>   digests are collected.
>   These digests are hashed together with with the current block cipher key to
>   produce the new block cipher key.
> 
> Ferguson goes into detail in Practical Cryptography as to why this design is
> superior to Yarrow based RNG (like the existing Linux RNG) and also delves
> into why entropy estimation is impossible and is infact a liability in RNG
> design.
> 
> My patch keep the entropy estimation from the current Linux RNG since this is
> a very controversial issue with most people.  Disabling entropy estimation
> and /dev/random blocking can be done by changing the RANDOM_NO_ENTROPY_COUNT
> macro to 1.
> 
> I have not tested the syncookie code yet.  But networking works smoothly
> after I echo "1" to /proc/sys/net/ipv4/tcp_syncookies.  Any help on this
> would be great.
> 
> JLC
> _______________________________________________
> 
> Subscription: http://lists.logix.cz/mailman/listinfo/cryptoapi
> List archive: http://lists.logix.cz/pipermail/cryptoapi

--oFbHfjnMgUMsrGjO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fortuna-random-2.6.11.4.patch"

--- linux-2.6.11.6/crypto/Kconfig	2005-03-25 22:28:37.000000000 -0500
+++ linux-2.6.11.6-fort/crypto/Kconfig	2005-03-30 09:11:12.000000000 -0500
@@ -9,6 +9,20 @@
 	help
 	  This option provides the core Cryptographic API.
 
+config CRYPTO_RANDOM_FORTUNA
+	bool "The Fortuna CSRNG"
+	depends on CRYPTO && EXPERIMENTAL
+	select CRYPTO_SHA256
+	select CRYPTO_AES if !(CRYPTO && (X86 && !X86_64))
+	select CRYPTO_AES_586 if CRYPTO && (X86 && !X86_64)
+	help
+	  Replaces the legacy Linux RNG with one using the CryptoAPI
+	  and Fortuna designed by Ferguson and Schneier.  Entropy estimation,
+	  and a throttled /dev/random remain.  Improvements include faster
+	  /dev/urandom output and event input mixing.  Entropy estimation
+	  can be removed by changing source code.
+	  Note: Requires AES and SHA256 to be built-in.
+
 config CRYPTO_HMAC
 	bool "HMAC support"
 	depends on CRYPTO
--- linux-2.6.11.6/drivers/char/random-fortuna.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.11.6-fort/drivers/char/random-fortuna.c	2005-03-31 08:54:37.321371752 -0500
@@ -0,0 +1,2121 @@
+/*
+ * random-fortuna.c -- A cryptographically strong random number generator
+ *			using Fortuna.
+ *
+ * Version 2.1.7, last modified 29-Mar-2005
+ * Change log:
+ *  v2.1.7:
+ * 	- Ported to 2.6.11.4
+ *  v2.1.6:
+ *	- Sami Farin pointed out RANDOM_MAX_BLOCK_SIZE was used for __u32[]'s
+ *	  and u8[]'s, fixed.
+ *	- Sami also found TCP sequence numbers wern't very secure.  Typo
+ *	  in code fixed.
+ *	- Sami found crypto_cipher_encrypt() uses nbytes and not
+ *	  numscatterlists.  Fixed.
+ *  v2.1.5:
+ *	- random-fortuna.c is no longer #include'd from random.c, the
+ *	  drivers/char/Makefile takes care of this now thanks to Chris Han
+ *  v2.1.4:
+ *	- Fixed flaw where some situations, /dev/random would not block.
+ *  v2.1.3:
+ *	- Added a seperate round-robin index for use inputs.  Avoids a
+ *	  super-cleaver user from forcing all system (unknown) random
+ *	  events from being fed into, say, pool-31.
+ *	- Added a "can only extract RANDOM_MAX_EXTRACT_SIZE bytes at a time"
+ *	  to extract_entropy()
+ *  v2.1.2:
+ *	- Ts'o's (I love writting that!) recomendation to force reseeds
+ * 	  to be at least 0.1 ms apart (complies with Ferguson/Schnier's
+ *	  design).
+ *  v2.1.1:
+ * 	- Re-worked to keep the blocking /dev/random.  Yes I finally gave
+ *	  in to what everyone's been telling me.
+ *	- Entropy accounting is *only* done on events going into pool-0
+ *	  since it's used for every reseed.  Those who expect /dev/random
+ *	  to only output data when the system is confident it has
+ *	  info-theoretic entropy to justify this output, this is the only
+ *	  sensible method to count entropy.
+ *  v2.0:
+ *	- Inital version
+ * 
+ * Copyright Theodore Ts'o, 1994, 1995, 1996, 1997, 1998, 1999.  All
+ * rights reserved.
+ * Copyright Jean-Luc Cooke, 2004.  All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, and the entire permission notice in its entirety,
+ *    including the disclaimer of warranties.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. The name of the author may not be used to endorse or promote
+ *    products derived from this software without specific prior
+ *    written permission.
+ * 
+ * ALTERNATIVELY, this product may be distributed under the terms of
+ * the GNU General Public License, in which case the provisions of the GPL are
+ * required INSTEAD OF the above restrictions.  (This clause is
+ * necessary due to a potential bad interaction between the GPL and
+ * the restrictions contained in a BSD-style copyright.)
+ * 
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, ALL OF
+ * WHICH ARE HEREBY DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
+ * OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
+ * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
+ * USE OF THIS SOFTWARE, EVEN IF NOT ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
+ */
+
+/*
+ * Taken from random.c, updated by Jean-Luc Cooke <jlcooke@certainkey.com>
+ * (now, with legal B.S. out of the way.....) 
+ * 
+ * This routine gathers environmental noise from device drivers, etc.,
+ * and returns good random numbers, suitable for cryptographic use.
+ * Besides the obvious cryptographic uses, these numbers are also good
+ * for seeding TCP sequence numbers, and other places where it is
+ * desirable to have numbers which are not only random, but hard to
+ * predict by an attacker.
+ *
+ * Theory of operation
+ * ===================
+ * 
+ * Computers are very predictable devices.  Hence it is extremely hard
+ * to produce truly random numbers on a computer --- as opposed to
+ * pseudo-random numbers, which can easily generated by using a
+ * algorithm.  Unfortunately, it is very easy for attackers to guess
+ * the sequence of pseudo-random number generators, and for some
+ * applications this is not acceptable.  So instead, we must try to
+ * gather "environmental noise" from the computer's environment, which
+ * must be hard for outside attackers to observe, and use that to
+ * generate random numbers.  In a Unix environment, this is best done
+ * from inside the kernel.
+ * 
+ * Sources of randomness from the environment include inter-keyboard
+ * timings, inter-interrupt timings from some interrupts, and other
+ * events which are both (a) non-deterministic and (b) hard for an
+ * outside observer to measure.  Randomness from these sources are
+ * added to an "entropy pool", which is mixed.
+ * As random bytes are mixed into the entropy pool, the routines keep
+ * an *estimate* of how many bits of randomness have been stored into
+ * the random number generator's internal state.
+ * 
+ * Even if it is possible to analyze Fortuna in some clever way, as
+ * long as the amount of data returned from the generator is less than
+ * the inherent entropy we've estimated in the pool, the output data
+ * is totally unpredictable.  For this reason, the routine decreases
+ * its internal estimate of how many bits of "true randomness" are
+ * contained in the entropy pool as it outputs random numbers.
+ * 
+ * If this estimate goes to zero, the routine can still generate
+ * random numbers; however, an attacker may (at least in theory) be
+ * able to infer the future output of the generator from prior
+ * outputs.  This requires successful cryptanalysis of Fortuna, which is
+ * not believed to be feasible, but there is a remote possibility.
+ * Nonetheless, these numbers should be useful for the vast majority
+ * of purposes.
+ * 
+ * Exported interfaces ---- output
+ * ===============================
+ * 
+ * There are three exported interfaces; the first is one designed to
+ * be used from within the kernel:
+ *
+ * 	void get_random_bytes(void *buf, int nbytes);
+ *
+ * This interface will return the requested number of random bytes,
+ * and place it in the requested buffer.
+ * 
+ * The two other interfaces are two character devices /dev/random and
+ * /dev/urandom.  /dev/random is suitable for use when very high
+ * quality randomness is desired (for example, for key generation or
+ * one-time pads), as it will only return a maximum of the number of
+ * bits of randomness (as estimated by the random number generator)
+ * contained in the entropy pool.
+ * 
+ * The /dev/urandom device does not have this limit, and will return
+ * as many bytes as are requested.  As more and more random bytes are
+ * requested without giving time for the entropy pool to recharge,
+ * this will result in random numbers that are merely cryptographically
+ * strong.  For many applications, however, this is acceptable.
+ *
+ * Exported interfaces ---- input
+ * ==============================
+ * 
+ * The current exported interfaces for gathering environmental noise
+ * from the devices are:
+ * 
+ * 	void add_keyboard_randomness(unsigned char scancode);
+ * 	void add_mouse_randomness(__u32 mouse_data);
+ * 	void add_interrupt_randomness(int irq);
+ * 
+ * add_keyboard_randomness() uses the inter-keypress timing, as well as the
+ * scancode as random inputs into the "entropy pool".
+ * 
+ * add_mouse_randomness() uses the mouse interrupt timing, as well as
+ * the reported position of the mouse from the hardware.
+ *
+ * add_interrupt_randomness() uses the inter-interrupt timing as random
+ * inputs to the entropy pool.  Note that not all interrupts are good
+ * sources of randomness!  For example, the timer interrupts is not a
+ * good choice, because the periodicity of the interrupts is too
+ * regular, and hence predictable to an attacker.  Disk interrupts are
+ * a better measure, since the timing of the disk interrupts are more
+ * unpredictable.
+ * 
+ * All of these routines try to estimate how many bits of randomness a
+ * particular randomness source.  They do this by keeping track of the
+ * first and second order deltas of the event timings.
+ *
+ * Ensuring unpredictability at system startup
+ * ============================================
+ * 
+ * When any operating system starts up, it will go through a sequence
+ * of actions that are fairly predictable by an adversary, especially
+ * if the start-up does not involve interaction with a human operator.
+ * This reduces the actual number of bits of unpredictability in the
+ * entropy pool below the value in entropy_count.  In order to
+ * counteract this effect, it helps to carry information in the
+ * entropy pool across shut-downs and start-ups.  To do this, put the
+ * following lines an appropriate script which is run during the boot
+ * sequence: 
+ *
+ *	echo "Initializing random number generator..."
+ *	random_seed=/var/run/random-seed
+ *	# Carry a random seed from start-up to start-up
+ *	# Load and then save the whole entropy pool
+ *	if [ -f $random_seed ]; then
+ *		cat $random_seed >/dev/urandom
+ *	else
+ *		touch $random_seed
+ *	fi
+ *	chmod 600 $random_seed
+ *	dd if=/dev/urandom of=$random_seed count=8 bs=256
+ *
+ * and the following lines in an appropriate script which is run as
+ * the system is shutdown:
+ *
+ *	# Carry a random seed from shut-down to start-up
+ *	# Save the whole entropy pool
+ * 	# Fortuna resists using all of its pool matirial, so we need to
+ *      # draw 8 seperate times (count=8) to ensure we get the entropy
+ *	# from pool[0,1,2,3]'s entropy.  count=2048 pool[0 .. 10], etc.
+ *	echo "Saving random seed..."
+ *	random_seed=/var/run/random-seed
+ *	touch $random_seed
+ *	chmod 600 $random_seed
+ *	dd if=/dev/urandom of=$random_seed count=8 bs=256
+ *
+ * For example, on most modern systems using the System V init
+ * scripts, such code fragments would be found in
+ * /etc/rc.d/init.d/random.  On older Linux systems, the correct script
+ * location might be in /etc/rcb.d/rc.local or /etc/rc.d/rc.0.
+ * 
+ * Effectively, these commands cause the contents of the entropy pool
+ * to be saved at shut-down time and reloaded into the entropy pool at
+ * start-up.  (The 'dd' in the addition to the bootup script is to
+ * make sure that /etc/random-seed is different for every start-up,
+ * even if the system crashes without executing rc.0.)  Even with
+ * complete knowledge of the start-up activities, predicting the state
+ * of the entropy pool requires knowledge of the previous history of
+ * the system.
+ *
+ * Configuring the /dev/random driver under Linux
+ * ==============================================
+ *
+ * The /dev/random driver under Linux uses minor numbers 8 and 9 of
+ * the /dev/mem major number (#1).  So if your system does not have
+ * /dev/random and /dev/urandom created already, they can be created
+ * by using the commands:
+ *
+ * 	mknod /dev/random c 1 8
+ * 	mknod /dev/urandom c 1 9
+ * 
+ * Acknowledgements:
+ * =================
+ *
+ * Ideas for constructing this random number generator were derived
+ * from Pretty Good Privacy's random number generator, and from private
+ * discussions with Phil Karn.  Colin Plumb provided a faster random
+ * number generator, which speed up the mixing function of the entropy
+ * pool, taken from PGPfone.  Dale Worley has also contributed many
+ * useful ideas and suggestions to improve this driver.
+ * 
+ * Any flaws in the design are solely my (jlcooke) responsibility, and
+ * should not be attributed to the Phil, Colin, or any of authors of PGP
+ * or the legacy random.c (Ted Ts'o).
+ * 
+ * Further background information on this topic may be obtained from
+ * RFC 1750, "Randomness Recommendations for Security", by Donald
+ * Eastlake, Steve Crocker, and Jeff Schiller.  And Chapter 10 of
+ * Practical Cryptography by Ferguson and Schneier.
+ */
+
+#include <linux/utsname.h>
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/major.h>
+#include <linux/string.h>
+#include <linux/fcntl.h>
+#include <linux/slab.h>
+#include <linux/random.h>
+#include <linux/poll.h>
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/workqueue.h>
+#include <linux/genhd.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/percpu.h>
+#include <linux/crypto.h>
+
+#include <asm/scatterlist.h>
+#include <asm/processor.h>
+#include <asm/uaccess.h>
+#include <asm/irq.h>
+#include <asm/io.h>
+
+
+/*
+ * Configuration information
+ */
+
+/* Set to 1 to disable entropy estimation (once it reaches its max) and
+ * blocking of /dev/random */
+#define RANDOM_NO_ENTROPY_COUNT 0
+/* Queue of input events to queue for input into our pools */
+#define BATCH_ENTROPY_SIZE 256
+/* micro-seconds between random_reseeds for non-blocking reads */
+#define RANDOM_RESEED_INTERVAL 100
+/*
+ * Number of bytes you can extract at a time, 1MB is recomended in
+ * Practical Cryptography rev-0
+ */
+#define RANDOM_MAX_EXTRACT_SIZE  (1<<20)
+#define RANDOM_DEFAULT_DIGEST_ALGO "sha256"
+#define RANDOM_DEFAULT_CIPHER_ALGO "aes"
+/* Alternatives */
+//#define RANDOM_DEFAULT_DIGEST_ALGO "whirlpool"
+//#define RANDOM_DEFAULT_CIPHER_ALGO "twofish"
+
+#define DEFAULT_POOL_NUMBER 5 /* 2^{5} = 32 pools */
+#define DEFAULT_POOL_SIZE ( (1<<DEFAULT_POOL_NUMBER) * 256)
+/* largest block of random data to extract at a time when in blocking-mode */
+#define TMP_BUF_SIZE		512
+/* SHA512/WHIRLPOOL have 64bytes == 512 bits */
+#define RANDOM_MAX_DIGEST_SIZE	64
+/* AES256 has 16byte blocks == 128 bits */
+#define RANDOM_MAX_BLOCK_SIZE	16
+/* AES256 has 32byte keys == 256 bits */
+#define RANDOM_MAX_KEY_SIZE	32
+
+/*
+ * The minimum number of bits of entropy before we wake up a read on
+ * /dev/random.  We also wait for reseed_count>0 and we do a 
+ * random_reseed() once we do wake up.
+ */
+static int random_read_wakeup_thresh = 64;
+
+/*
+ * If the entropy count falls under this number of bits, then we
+ * should wake up processes which are selecting or polling on write
+ * access to /dev/random.
+ */
+static int random_write_wakeup_thresh = 128;
+
+/*
+ * When the input pool goes over trickle_thresh, start dropping most
+ * samples to avoid wasting CPU time and reduce lock contention.
+ */
+
+static int trickle_thresh = DEFAULT_POOL_SIZE * 7;
+
+static DEFINE_PER_CPU(int, trickle_count) = 0;
+
+#define POOLBYTES\
+	( (1<<random_state->pool_number) * random_state->digestsize )
+#define POOLBITS	( POOLBYTES * 8 )
+
+/*
+ * Linux 2.2 compatibility
+ */
+#ifndef DECLARE_WAITQUEUE
+#define DECLARE_WAITQUEUE(WAIT, PTR)	struct wait_queue WAIT = { PTR, NULL }
+#endif
+#ifndef DECLARE_WAIT_QUEUE_HEAD
+#define DECLARE_WAIT_QUEUE_HEAD(WAIT) struct wait_queue *WAIT
+#endif
+
+/*
+ * Static global variables
+ */
+static struct entropy_store *random_state; /* The default global store */
+static DECLARE_WAIT_QUEUE_HEAD(random_read_wait);
+static DECLARE_WAIT_QUEUE_HEAD(random_write_wait);
+
+/*
+ * Forward procedure declarations
+ */
+#ifdef CONFIG_SYSCTL
+static void sysctl_init_random(struct entropy_store *random_state);
+#endif
+
+/*****************************************************************
+ *
+ * Utility functions, with some ASM defined functions for speed
+ * purposes
+ * 
+ *****************************************************************/
+
+/*
+ * More asm magic....
+ * 
+ * For entropy estimation, we need to do an integral base 2
+ * logarithm.  
+ *
+ * Note the "12bits" suffix - this is used for numbers between
+ * 0 and 4095 only.  This allows a few shortcuts.
+ */
+#if 0	/* Slow but clear version */
+static inline __u32 int_ln_12bits(__u32 word)
+{
+	__u32 nbits = 0;
+	
+	while (word >>= 1)
+		nbits++;
+	return nbits;
+}
+#else	/* Faster (more clever) version, courtesy Colin Plumb */
+static inline __u32 int_ln_12bits(__u32 word)
+{
+	/* Smear msbit right to make an n-bit mask */
+	word |= word >> 8;
+	word |= word >> 4;
+	word |= word >> 2;
+	word |= word >> 1;
+	/* Remove one bit to make this a logarithm */
+	word >>= 1;
+	/* Count the bits set in the word */
+	word -= (word >> 1) & 0x555;
+	word = (word & 0x333) + ((word >> 2) & 0x333);
+	word += (word >> 4);
+	word += (word >> 8);
+	return word & 15;
+}
+#endif
+
+#if 0
+	#define DEBUG_ENT(fmt, arg...) printk("random: " fmt, ## arg)
+#else
+	#define DEBUG_ENT(fmt, arg...) do {} while (0)
+#endif
+#if 0
+	#define STATS_ENT(fmt, arg...) printk("random-stats: " fmt, ## arg)
+#else
+	#define STATS_ENT(fmt, arg...) do {} while (0)
+#endif
+
+
+/**********************************************************************
+ *
+ * OS independent entropy store.   Here are the functions which handle
+ * storing entropy in an entropy pool.
+ * 
+ **********************************************************************/
+
+struct entropy_store {
+	const char *digestAlgo;
+	unsigned int  digestsize;
+	struct crypto_tfm *pools[1<<DEFAULT_POOL_NUMBER];
+	/* optional, handy for statistics */
+	unsigned int pools_bytes[1<<DEFAULT_POOL_NUMBER];
+
+	const char *cipherAlgo;
+	/* the key */
+	unsigned char key[RANDOM_MAX_DIGEST_SIZE];
+	unsigned int  keysize;
+	/* the CTR value */
+	unsigned char iv[16];
+	unsigned int  blocksize;
+	struct crypto_tfm *cipher;
+
+	/* 2^pool_number # of pools */
+	unsigned int  pool_number;
+	/* current pool to add into */
+	unsigned int  pool_index;
+	/* size of the first pool */
+	unsigned int  pool0_len;
+	/* number of time we have reset */
+	unsigned int  reseed_count;
+	/* time in msec of the last reseed */
+	time_t reseed_time;
+	/* digest used during random_reseed() */
+	struct crypto_tfm *reseedHash;
+	/* cipher used for network randomness */
+	struct crypto_tfm *networkCipher;
+	/* flag indicating if networkCipher has been seeded */
+	char networkCipher_ready;
+
+	/* read-write data: */
+	spinlock_t lock ____cacheline_aligned_in_smp;
+	int		entropy_count;
+#if RANDOM_NO_ENTROPY_COUNT
+	int		entropy_count_bogus;
+#endif
+};
+
+/*
+ * Initialize the entropy store.  The input argument is the size of
+ * the random pool.
+ *
+ * Returns an negative error if there is a problem.
+ */
+static int create_entropy_store(int poolnum, struct entropy_store **ret_bucket)
+{
+	struct  entropy_store   *r;
+	unsigned long pool_number;
+	int     keysize, i, j;
+
+	pool_number = poolnum;
+
+	r = kmalloc(sizeof(struct entropy_store), GFP_KERNEL);
+	if (!r) {
+		return -ENOMEM;
+	}
+
+	memset (r, 0, sizeof(struct entropy_store));
+	r->pool_number = pool_number;
+	r->digestAlgo = RANDOM_DEFAULT_DIGEST_ALGO;
+
+	DEBUG_ENT("create_entropy_store() pools=%u index=%u\n",
+			1<<pool_number, r->pool_index);
+	for (i=0; i<(1<<pool_number); i++) {
+		DEBUG_ENT("create_entropy_store() i=%i index=%u\n",
+				i, r->pool_index);
+		r->pools[i] = crypto_alloc_tfm(r->digestAlgo, 0);
+		if (r->pools[i] == NULL) {
+			for (j=0; j<i; j++) {
+				if (r->pools[j] != NULL) {
+					kfree(r->pools[j]);
+				}
+			}
+			kfree(r);
+			return -ENOMEM;
+		}
+		crypto_digest_init( r->pools[i] );
+	}
+	r->lock = SPIN_LOCK_UNLOCKED;
+	*ret_bucket = r;
+
+	r->cipherAlgo = RANDOM_DEFAULT_CIPHER_ALGO;
+	if ((r->cipher=crypto_alloc_tfm(r->cipherAlgo, 0)) == NULL) {
+		return -ENOMEM;
+	}
+
+	/* If the HASH's output is greater then the cipher's keysize, truncate
+	 * to the cipher's keysize */
+	keysize = crypto_tfm_alg_max_keysize(r->cipher);
+	r->digestsize = crypto_tfm_alg_digestsize(r->pools[0]);
+	r->blocksize = crypto_tfm_alg_blocksize(r->cipher);
+
+	r->keysize = (keysize < r->digestsize) ? keysize : r->digestsize;
+DEBUG_ENT("create_RANDOM %u %u %u\n", keysize, r->digestsize, r->keysize);
+
+	if (crypto_cipher_setkey(r->cipher, r->key, r->keysize)) {
+		return -EINVAL;
+	}
+
+	/* digest used during random-reseed() */
+	if ((r->reseedHash=crypto_alloc_tfm(r->digestAlgo, 0)) == NULL) {
+		return -ENOMEM;
+	}
+	/* cipher used for network randomness */
+	if ((r->networkCipher=crypto_alloc_tfm(r->cipherAlgo, 0)) == NULL) {
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+/*
+ * This function adds a byte into the entropy "pool".  It does not
+ * update the entropy estimate.  The caller should call
+ * credit_entropy_store if this is appropriate.
+ */
+static void add_entropy_words(struct entropy_store *r, const __u32 *in,
+			      int nwords, int dst_pool)
+{
+	unsigned long flags;
+	struct scatterlist sg[1];
+	static unsigned int totalBytes=0;
+	static unsigned int keyidx = 0;
+
+	if (r == NULL)
+		return;
+
+	spin_lock_irqsave(&r->lock, flags);
+
+	totalBytes += nwords * sizeof(__u32);
+
+	sg[0].page = virt_to_page(in);
+	sg[0].offset = offset_in_page(in);
+	sg[0].length = nwords*sizeof(__u32);
+
+	if (dst_pool == -1) {
+		r->pools_bytes[r->pool_index] += nwords * sizeof(__u32);
+		crypto_digest_update(r->pools[r->pool_index], sg, 1);
+		if (r->pool_index == 0) {
+			r->pool0_len += nwords*sizeof(__u32);
+		}
+		/* idx = (idx + r) mod ( (2^N)-1 ) */
+		r->pool_index = (r->pool_index + r->key[keyidx])
+					& ((1<<random_state->pool_number)-1);
+		/* first 8 bytes of the key are used, 8 * 8 = 64 bits */
+		keyidx = (keyidx + 1) & 7;
+	} else {
+		/* Let's make sure nothing mean is happening... */
+		dst_pool &= (1<<random_state->pool_number) - 1;
+		r->pools_bytes[dst_pool] += nwords * sizeof(__u32);
+		crypto_digest_update(r->pools[dst_pool], sg, 1);
+	}
+DEBUG_ENT("r->pool0_len = %u\n", r->pool0_len);
+
+
+	spin_unlock_irqrestore(&r->lock, flags);
+DEBUG_ENT("0 add_entropy_words() nwords=%u pool[i].bytes=%u total=%u\n",
+	nwords, r->pools_bytes[r->pool_index], totalBytes);
+}
+
+/*
+ * Credit (or debit) the entropy store with n bits of entropy
+ */
+static void credit_entropy_store(struct entropy_store *r, int nbits)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&r->lock, flags);
+
+	if (r->entropy_count + nbits < 0) {
+		DEBUG_ENT("negative entropy/overflow (%d+%d)\n",
+			  r->entropy_count, nbits);
+		r->entropy_count = 0;
+	} else if (r->entropy_count + nbits > POOLBITS) {
+		r->entropy_count = POOLBITS;
+	} else {
+		r->entropy_count += nbits;
+		if (nbits)
+			DEBUG_ENT("%04d : added %d bits\n",
+				  r->entropy_count,
+				  nbits);
+	}
+
+	spin_unlock_irqrestore(&r->lock, flags);
+}
+
+/**********************************************************************
+ *
+ * Entropy batch input management
+ *
+ * We batch entropy to be added to avoid increasing interrupt latency
+ *
+ **********************************************************************/
+
+struct sample {
+	__u32 data[2];
+	int credit;
+};
+
+static struct sample *batch_entropy_pool, *batch_entropy_copy;
+static int	batch_head, batch_tail;
+static spinlock_t batch_lock = SPIN_LOCK_UNLOCKED;
+
+static int	batch_max;
+static void batch_entropy_process(void *private_);
+static DECLARE_WORK(batch_work, batch_entropy_process, NULL);
+
+/* note: the size must be a power of 2 */
+static int __init batch_entropy_init(int size, struct entropy_store *r)
+{
+	batch_entropy_pool = kmalloc(size*sizeof(struct sample), GFP_KERNEL);
+	if (!batch_entropy_pool)
+		return -1;
+	batch_entropy_copy = kmalloc(size*sizeof(struct sample), GFP_KERNEL);
+	if (!batch_entropy_copy) {
+		kfree(batch_entropy_pool);
+		return -1;
+	}
+	batch_head = batch_tail = 0;
+	batch_work.data = r;
+	batch_max = size;
+	return 0;
+}
+
+/*
+ * Changes to the entropy data is put into a queue rather than being added to
+ * the entropy counts directly.  This is presumably to avoid doing heavy
+ * hashing calculations during an interrupt in add_timer_randomness().
+ * Instead, the entropy is only added to the pool by keventd.
+ */
+void batch_entropy_store(u32 a, u32 b, int num)
+{
+	int new;
+	unsigned long flags;
+
+	if (!batch_max)
+		return;
+
+	spin_lock_irqsave(&batch_lock, flags);
+
+	batch_entropy_pool[batch_head].data[0] = a;
+	batch_entropy_pool[batch_head].data[1] = b;
+	batch_entropy_pool[batch_head].credit = num;
+
+	if (((batch_head - batch_tail) & (batch_max-1)) >= (batch_max / 2)) {
+		/*
+		 * Schedule it for the next timer tick:
+		 */
+		schedule_delayed_work(&batch_work, 1);
+	}
+
+	new = (batch_head+1) & (batch_max-1);
+	if (new == batch_tail) {
+		DEBUG_ENT("batch entropy buffer full\n");
+	} else {
+		batch_head = new;
+	}
+
+	spin_unlock_irqrestore(&batch_lock, flags);
+}
+
+EXPORT_SYMBOL(batch_entropy_store);
+
+/*
+ * Flush out the accumulated entropy operations, adding entropy to the passed
+ * store (normally random_state).  If that store has enough entropy, alternate
+ * between randomizing the data of the primary and secondary stores.
+ */
+static void batch_entropy_process(void *private_)
+{
+	int max_entropy = POOLBITS;
+	unsigned head, tail;
+
+	/* Mixing into the pool is expensive, so copy over the batch
+	 * data and release the batch lock. The pool is at least half
+	 * full, so don't worry too much about copying only the used
+	 * part.
+	 */
+	spin_lock_irq(&batch_lock);
+
+	memcpy(batch_entropy_copy, batch_entropy_pool,
+	       batch_max*sizeof(struct sample));
+
+	head = batch_head;
+	tail = batch_tail;
+	batch_tail = batch_head;
+
+	spin_unlock_irq(&batch_lock);
+
+	while (head != tail) {
+		if (random_state->entropy_count >= max_entropy) {
+			max_entropy = POOLBITS;
+		}
+		/*
+		 * Only credit if we're feeding into pool[0]
+		 * Otherwise we'd be assuming entropy in pool[31] would be
+		 * usable when we read.  This is conservative, but it'll
+		 * not over-credit our entropy estimate for users of
+		 * /dev/random, /dev/urandom will not be effected.
+		 */
+		if (random_state->pool_index == 0) {
+			credit_entropy_store(random_state,
+				batch_entropy_copy[tail].credit);
+		}
+		add_entropy_words(random_state,
+			batch_entropy_copy[tail].data, 2, -1);
+;
+
+		tail = (tail+1) & (batch_max-1);
+	}
+	if (random_state->entropy_count >= random_read_wakeup_thresh
+		&& random_state->reseed_count != 0)
+		wake_up_interruptible(&random_read_wait);
+}
+
+/*********************************************************************
+ *
+ * Entropy input management
+ *
+ *********************************************************************/
+
+/* There is one of these per entropy source */
+struct timer_rand_state {
+	__u32		last_time;
+	__s32		last_delta,last_delta2;
+	int		dont_count_entropy:1;
+};
+
+static struct timer_rand_state input_timer_state;
+static struct timer_rand_state extract_timer_state;
+static struct timer_rand_state *irq_timer_state[NR_IRQS];
+
+/*
+ * This function adds entropy to the entropy "pool" by using timing
+ * delays.  It uses the timer_rand_state structure to make an estimate
+ * of how many bits of entropy this call has added to the pool.
+ *
+ * The number "num" is also added to the pool - it should somehow describe
+ * the type of event which just happened.  This is currently 0-255 for
+ * keyboard scan codes, and 256 upwards for interrupts.
+ * On the i386, this is assumed to be at most 16 bits, and the high bits
+ * are used for a high-resolution timer.
+ *
+ */
+static void add_timer_randomness(struct timer_rand_state *state, unsigned num)
+{
+	__u32		time;
+	__s32		delta, delta2, delta3;
+	int		entropy = 0;
+
+	/* if over the trickle threshold, use only 1 in 4096 samples */
+	if ( random_state->entropy_count > trickle_thresh &&
+	     (__get_cpu_var(trickle_count)++ & 0xfff))
+		return;
+
+#if defined (__i386__) || defined (__x86_64__)
+	if (cpu_has_tsc) {
+		__u32 high;
+		rdtsc(time, high);
+		num ^= high;
+	} else {
+		time = jiffies;
+	}
+#elif defined (__sparc_v9__)
+	unsigned long tick = tick_ops->get_tick();
+
+	time = (unsigned int) tick;
+	num ^= (tick >> 32UL);
+#else
+	time = jiffies;
+#endif
+
+	/*
+	 * Calculate number of bits of randomness we probably added.
+	 * We take into account the first, second and third-order deltas
+	 * in order to make our estimate.
+	 */
+	if (!state->dont_count_entropy) {
+		delta = time - state->last_time;
+		state->last_time = time;
+
+		delta2 = delta - state->last_delta;
+		state->last_delta = delta;
+
+		delta3 = delta2 - state->last_delta2;
+		state->last_delta2 = delta2;
+
+		if (delta < 0)
+			delta = -delta;
+		if (delta2 < 0)
+			delta2 = -delta2;
+		if (delta3 < 0)
+			delta3 = -delta3;
+		if (delta > delta2)
+			delta = delta2;
+		if (delta > delta3)
+			delta = delta3;
+
+		/*
+		 * delta is now minimum absolute delta.
+		 * Round down by 1 bit on general principles,
+		 * and limit entropy entimate to 12 bits.
+		 */
+		delta >>= 1;
+		delta &= (1 << 12) - 1;
+
+		entropy = int_ln_12bits(delta);
+	}
+	batch_entropy_store(num, time, entropy);
+}
+
+extern void add_input_randomness(unsigned int type, unsigned int code,
+			 unsigned int value)
+{
+	static unsigned int last_value;
+
+	/* ignore autorepeat (multiple key down w/o key up) */
+	if (value != last_value)
+		return;
+
+	DEBUG_ENT("input event\n");
+	last_value = value;
+	add_timer_randomness(&input_timer_state,
+			(type << 4) ^ code ^ (code >> 4) ^ value);
+}
+
+void add_interrupt_randomness(int irq)
+{
+	if (irq >= NR_IRQS || irq_timer_state[irq] == 0)
+		return;
+
+	add_timer_randomness(irq_timer_state[irq], 0x100+irq);
+}
+
+EXPORT_SYMBOL(add_interrupt_randomness);
+
+void add_disk_randomness(struct gendisk *disk)
+{
+	if (!disk || !disk->random)
+		return;
+	/* first major is 1, so we get >= 0x200 here */
+	add_timer_randomness(disk->random,
+				0x100+MKDEV(disk->major, disk->first_minor));
+}
+
+EXPORT_SYMBOL(add_disk_randomness);
+
+/*********************************************************************
+ *
+ * Entropy extraction routines
+ *
+ *********************************************************************/
+
+#define EXTRACT_ENTROPY_USER		1
+#define EXTRACT_ENTROPY_LIMIT		4
+
+static ssize_t extract_entropy(struct entropy_store *r, void * buf,
+			       size_t nbytes, int flags);
+
+static inline void increment_iv(unsigned char *iv, const unsigned int IVsize) {
+	switch (IVsize) {
+	case 8:
+		if (++((u32*)iv)[0])
+			++((u32*)iv)[1];
+	break;
+
+	case 16:
+		if (++((u32*)iv)[0])
+			if (++((u32*)iv)[1])
+				if (++((u32*)iv)[2])
+					++((u32*)iv)[3];
+	break;
+
+	default:
+		{
+		int i;
+		for (i=0; i<IVsize; i++)
+			if (++iv[i])
+				break;
+		}
+	break;
+	}
+}
+
+/*
+ * Fortuna's Reseed
+ * 
+ * Key' = hash(Key || hash(pool[a0]) || hash(pool[a1]) || ...)
+ * where {a0,a1,...} are facators of r->reseed_count+1 which are of the form
+ * 2^j, 0<=j.
+ * Prevents backtracking attacks and with event inputs, supports forward
+ * secrecy
+ */
+static void random_reseed(struct entropy_store *r, size_t nbytes, int flags) {
+	struct scatterlist sg[1];
+	unsigned int i, deduct;
+	unsigned char tmp[RANDOM_MAX_DIGEST_SIZE];
+	unsigned long cpuflags;
+ 
+	deduct = (r->keysize < r->digestsize) ? r->keysize : r->digestsize;
+
+	/* Hold lock while accounting */
+	spin_lock_irqsave(&r->lock, cpuflags);
+
+	DEBUG_ENT("%04d : trying to extract %d bits\n",
+		  random_state->entropy_count,
+		  deduct * 8);
+
+	/*
+	 * Don't extract more data than in the entropy in the pooling system
+	 */
+	if (flags & EXTRACT_ENTROPY_LIMIT && nbytes >= r->entropy_count / 8) {
+		nbytes = r->entropy_count / 8;
+	}
+
+	if (deduct*8 <= r->entropy_count) {
+		r->entropy_count -= deduct*8;
+	} else {
+		r->entropy_count = 0;
+	}
+
+	if (r->entropy_count < random_write_wakeup_thresh)
+		wake_up_interruptible(&random_write_wait);
+
+	DEBUG_ENT("%04d : debiting %d bits%s\n",
+		  random_state->entropy_count,
+		  deduct * 8,
+		  flags & EXTRACT_ENTROPY_LIMIT ? "" : " (unlimited)");
+
+	r->reseed_count++;
+	r->pool0_len = 0;
+
+	/* Entropy accounting done, release lock. */
+	spin_unlock_irqrestore(&r->lock, cpuflags);
+
+	DEBUG_ENT("random_reseed count=%u\n", r->reseed_count);
+
+	crypto_digest_init(r->reseedHash);
+
+	sg[0].page = virt_to_page(r->key);
+	sg[0].offset = offset_in_page(r->key);
+	sg[0].length = r->keysize;
+	crypto_digest_update(r->reseedHash, sg, 1);
+
+#define TESTBIT(VAL, N)\
+  ( ((VAL) >> (N)) & 1 )
+	for (i=0; i<(1<<r->pool_number); i++) {
+		/* using pool[i] if r->reseed_count is divisible by 2^i
+		 * since 2^0 == 1, we always use pool[0]
+		 */
+		if ( (i==0)  ||  TESTBIT(r->reseed_count,i)==0 ) {
+			crypto_digest_final(r->pools[i], tmp);
+
+			sg[0].page = virt_to_page(tmp);
+			sg[0].offset = offset_in_page(tmp);
+			sg[0].length = r->keysize;
+			crypto_digest_update(r->reseedHash, sg, 1);
+
+			crypto_digest_init(r->pools[i]);
+			/* Each pool carries its past state forward */
+			crypto_digest_update(r->pools[i], sg, 1);
+		} else {
+			/* pool j is only used once every 2^j times */
+			break;
+		}
+	}
+#undef TESTBIT
+
+	crypto_digest_final(r->reseedHash, r->key);
+	crypto_cipher_setkey(r->cipher, r->key, r->keysize);
+	increment_iv(r->iv, r->blocksize);
+}
+
+static inline time_t get_msectime(void) {
+	struct timeval tv;
+	do_gettimeofday(&tv);
+	return (tv.tv_sec * 1000) + (tv.tv_usec / 1000);
+}
+
+/*
+ * This function extracts randomness from the "entropy pool", and
+ * returns it in a buffer.  This function computes how many remaining
+ * bits of entropy are left in the pool, but it does not restrict the
+ * number of bytes that are actually obtained.  If the EXTRACT_ENTROPY_USER
+ * flag is given, then the buf pointer is assumed to be in user space.
+ */
+static ssize_t extract_entropy(struct entropy_store *r, void * buf,
+			       size_t nbytes, int flags)
+{
+	ssize_t ret, i;
+	__u32 tmp[RANDOM_MAX_BLOCK_SIZE/sizeof(__u32)];
+	struct scatterlist sgiv[1], sgtmp[1];
+	time_t nowtime;
+
+	/* Redundant, but just in case... */
+	if (r->entropy_count > POOLBITS)
+		r->entropy_count = POOLBITS;
+
+	/*
+	 * To keep the possibility of collisions down, limit the number of
+	 * output bytes per block cipher key.
+	 */
+	if (RANDOM_MAX_EXTRACT_SIZE < nbytes)
+		nbytes = RANDOM_MAX_EXTRACT_SIZE;
+
+	if (flags & EXTRACT_ENTROPY_LIMIT) {
+		/* if in blocking, only output upto the entropy estimate */
+		if (r->entropy_count/8 < nbytes)
+			nbytes = r->entropy_count/8;
+		/*
+		 * if blocking and there is no entropy by our estimate,
+		 * break out now.
+		 */
+		if (nbytes == 0)
+			return 0;
+	}
+
+	/*
+	 * If reading in non-blocking mode, pace ourselves in using up the pool
+	 * system's entropy.  reseed every .1 sec (Ferguson/Schnier)
+	 */
+	if (! (flags & EXTRACT_ENTROPY_LIMIT) ) {
+		nowtime = get_msectime();
+		if (r->pool0_len > 64
+		&& (nowtime - r->reseed_time) > RANDOM_RESEED_INTERVAL) {
+			random_reseed(r, nbytes, flags);
+			r->reseed_time = nowtime;
+		}
+	}
+
+	sgiv[0].page = virt_to_page(r->iv);
+	sgiv[0].offset = offset_in_page(r->iv);
+	sgiv[0].length = r->blocksize;
+	sgtmp[0].page = virt_to_page(tmp);
+	sgtmp[0].offset = offset_in_page(tmp);
+	sgtmp[0].length = r->blocksize;
+
+	ret = 0;
+	while (nbytes) {
+		/*
+		 * Check if we need to break out or reschedule....
+		 */
+		if ((flags & EXTRACT_ENTROPY_USER) && need_resched()) {
+			if (signal_pending(current)) {
+				if (ret == 0)
+					ret = -ERESTARTSYS;
+				break;
+			}
+
+			DEBUG_ENT("%04d : extract sleeping (%d bytes left)\n",
+				  random_state->entropy_count,
+				  nbytes);
+
+			schedule();
+
+			/*
+			 * when we wakeup, there will be more data in our
+			 * pooling system so we may reseed
+			 */
+			nowtime = get_msectime();
+			if (r->pool0_len > 64
+			&& (nowtime-r->reseed_time) > RANDOM_RESEED_INTERVAL) {
+				random_reseed(r, nbytes, flags);
+				r->reseed_time = nowtime;
+			}
+
+			DEBUG_ENT("%04d : extract woke up\n",
+				  random_state->entropy_count);
+		}
+
+		/*
+		 * Reading from /dev/random, we limit this to the amount
+		 * of entropy to deduct from our estimate.  This estimate is
+		 * most naturally updated from inside Fortuna-reseed, so we
+		 * limit our block size here.
+		 *
+		 * At most, Fortuna will use e=min(r->digestsize, r->keysize) of
+		 * entropy to reseed.
+		 */
+		if (flags & EXTRACT_ENTROPY_LIMIT) {
+			r->reseed_time = get_msectime();
+			random_reseed(r, nbytes, flags);
+		}
+
+		crypto_cipher_encrypt(r->cipher, sgtmp, sgiv, r->blocksize);
+		increment_iv(r->iv, r->blocksize);
+		
+		/* Copy data to destination buffer */
+		i = (nbytes < r->blocksize) ? nbytes : r->blocksize;
+		if (flags & EXTRACT_ENTROPY_USER) {
+			i -= copy_to_user(buf, (__u8 const *)tmp, i);
+			if (!i) {
+				ret = -EFAULT;
+				break;
+			}
+		} else
+			memcpy(buf, (__u8 const *)tmp, i);
+		nbytes -= i;
+		buf += i;
+		ret += i;
+	}
+
+	/* generate a new key */
+	/* take into account the possibility that keysize >= blocksize */
+	for (i=0; i+r->blocksize<=r->keysize; i+=r->blocksize) {
+		memcpy(tmp, r->key+i, r->blocksize);
+		crypto_cipher_encrypt(r->cipher, sgtmp, sgiv, r->blocksize);
+		increment_iv(r->iv, r->blocksize);
+	}
+	memcpy(tmp, r->key+i, r->keysize-i);
+	memset(tmp+r->keysize-i, 0, r->blocksize-(r->keysize-i));
+	crypto_cipher_encrypt(r->cipher, sgtmp, sgiv, r->blocksize);
+	increment_iv(r->iv, r->blocksize);
+
+	if (crypto_cipher_setkey(r->cipher, r->key, r->keysize)) {
+		return -EINVAL;
+	}
+
+	/* Wipe data just returned from memory */
+	memset(tmp, 0, sizeof(tmp));
+	
+	return ret;
+}
+
+/*
+ * This function is the exported kernel interface.  It returns some
+ * number of good random numbers, suitable for seeding TCP sequence
+ * numbers, etc.
+ */
+void get_random_bytes(void *buf, int nbytes)
+{
+	if (random_state)
+		extract_entropy(random_state, (char *) buf, nbytes, 0);
+	else
+		printk(KERN_NOTICE "get_random_bytes called before "
+				   "random driver initialization\n");
+}
+
+EXPORT_SYMBOL(get_random_bytes);
+
+/*********************************************************************
+ *
+ * Functions to interface with Linux
+ *
+ *********************************************************************/
+
+/*
+ * Initialize the random pool with standard stuff.
+ * This is not secure random data, but it can't hurt us and people scream
+ * when you try to remove it.
+ *
+ * NOTE: This is an OS-dependent function.
+ */
+static void init_std_data(struct entropy_store *r)
+{
+	struct timeval 	tv;
+	__u32		words[2];
+	char 		*p;
+	int		i;
+
+	do_gettimeofday(&tv);
+	words[0] = tv.tv_sec;
+	words[1] = tv.tv_usec;
+	batch_entropy_store(words[0], words[1], -1);
+
+	/*
+	 *	This doesn't lock system.utsname. However, we are generating
+	 *	entropy so a race with a name set here is fine.
+	 */
+	p = (char *) &system_utsname;
+	for (i = sizeof(system_utsname) / sizeof(words); i; i--) {
+		memcpy(words, p, sizeof(words));
+		batch_entropy_store(words[0], words[1], -1);
+		p += sizeof(words);
+	}
+}
+
+static int __init rand_initialize(void)
+{
+	int i;
+
+	if (create_entropy_store(DEFAULT_POOL_NUMBER, &random_state))
+		goto err;
+	if (batch_entropy_init(BATCH_ENTROPY_SIZE, random_state))
+		goto err;
+	init_std_data(random_state);
+#ifdef CONFIG_SYSCTL
+	sysctl_init_random(random_state);
+#endif
+	for (i = 0; i < NR_IRQS; i++)
+		irq_timer_state[i] = NULL;
+	memset(&input_timer_state, 0, sizeof(struct timer_rand_state));
+	memset(&extract_timer_state, 0, sizeof(struct timer_rand_state));
+	extract_timer_state.dont_count_entropy = 1;
+	return 0;
+err:
+	return -1;
+}
+module_init(rand_initialize);
+
+void rand_initialize_irq(int irq)
+{
+	struct timer_rand_state *state;
+	
+	if (irq >= NR_IRQS || irq_timer_state[irq])
+		return;
+
+	/*
+	 * If kmalloc returns null, we just won't use that entropy
+	 * source.
+	 */
+	state = kmalloc(sizeof(struct timer_rand_state), GFP_KERNEL);
+	if (state) {
+		memset(state, 0, sizeof(struct timer_rand_state));
+		irq_timer_state[irq] = state;
+	}
+}
+ 
+void rand_initialize_disk(struct gendisk *disk)
+{
+	struct timer_rand_state *state;
+	
+	/*
+	 * If kmalloc returns null, we just won't use that entropy
+	 * source.
+	 */
+	state = kmalloc(sizeof(struct timer_rand_state), GFP_KERNEL);
+	if (state) {
+		memset(state, 0, sizeof(struct timer_rand_state));
+		disk->random = state;
+	}
+}
+
+static ssize_t
+random_read(struct file * file, char __user * buf, size_t nbytes, loff_t *ppos)
+{
+	DECLARE_WAITQUEUE(wait, current);
+	ssize_t	n, retval = 0, count = 0;
+	
+	if (nbytes == 0)
+		return 0;
+
+	while (nbytes > 0) {
+		n = nbytes;
+
+		DEBUG_ENT("%04d : reading %d bits, p: %d s: %d\n",
+			  random_state->entropy_count,
+			  n*8, random_state->entropy_count,
+			  random_state->entropy_count);
+
+		n = extract_entropy(random_state, buf, n,
+				    EXTRACT_ENTROPY_USER |
+				    EXTRACT_ENTROPY_LIMIT);
+
+		DEBUG_ENT("%04d : read got %d bits (%d needed, reseeds=%d)\n",
+			  random_state->entropy_count,
+			  random_state->reseed_count,
+			  n*8, (nbytes-n)*8);
+
+		if (n == 0) {
+			if (file->f_flags & O_NONBLOCK) {
+				retval = -EAGAIN;
+				break;
+			}
+			if (signal_pending(current)) {
+				retval = -ERESTARTSYS;
+				break;
+			}
+
+			DEBUG_ENT("%04d : sleeping?\n",
+				  random_state->entropy_count);
+
+			set_current_state(TASK_INTERRUPTIBLE);
+			add_wait_queue(&random_read_wait, &wait);
+
+			if (random_state->entropy_count / 8 == 0
+				||  random_state->reseed_count == 0)
+				schedule();
+
+			set_current_state(TASK_RUNNING);
+			remove_wait_queue(&random_read_wait, &wait);
+
+			DEBUG_ENT("%04d : waking up\n",
+				  random_state->entropy_count);
+
+			continue;
+		}
+
+		if (n < 0) {
+			retval = n;
+			break;
+		}
+		count += n;
+		buf += n;
+		nbytes -= n;
+		break;		/* This break makes the device work */
+				/* like a named pipe */
+	}
+
+	/*
+	 * If we gave the user some bytes, update the access time.
+	 */
+	if (count)
+		file_accessed(file);
+	
+	return (count ? count : retval);
+}
+
+static ssize_t
+urandom_read(struct file * file, char __user * buf,
+		      size_t nbytes, loff_t *ppos)
+{
+	/* Don't return anything untill we've reseeded at least once */
+	if (random_state->reseed_count == 0)
+		return 0;
+
+	return extract_entropy(random_state, buf, nbytes,
+			       EXTRACT_ENTROPY_USER);
+}
+
+static unsigned int
+random_poll(struct file *file, poll_table * wait)
+{
+	unsigned int mask;
+
+	poll_wait(file, &random_read_wait, wait);
+	poll_wait(file, &random_write_wait, wait);
+	mask = 0;
+	if (random_state->entropy_count >= random_read_wakeup_thresh)
+		mask |= POLLIN | POLLRDNORM;
+	if (random_state->entropy_count < random_write_wakeup_thresh)
+		mask |= POLLOUT | POLLWRNORM;
+	return mask;
+}
+
+static ssize_t
+random_write(struct file * file, const char __user * buffer,
+	     size_t count, loff_t *ppos)
+{
+	static int	idx = 0;
+	int		ret = 0;
+	size_t		bytes;
+	__u32 		buf[16];
+	const char 	__user *p = buffer;
+	size_t		c = count;
+
+	while (c > 0) {
+		bytes = min(c, sizeof(buf));
+
+		bytes -= copy_from_user(&buf, p, bytes);
+		if (!bytes) {
+			ret = -EFAULT;
+			break;
+		}
+		c -= bytes;
+		p += bytes;
+
+		/*
+		 * Use input data rotates though the pools independantly of
+		 * system-events.
+		 *
+		 * idx = (idx + 1) mod ( (2^N)-1 )
+		 */
+		idx = (idx + 1) & ((1<<random_state->pool_number)-1);
+		add_entropy_words(random_state, buf, bytes, idx);
+	}
+	if (p == buffer) {
+		return (ssize_t)ret;
+	} else {
+		file->f_dentry->d_inode->i_mtime = CURRENT_TIME;
+		mark_inode_dirty(file->f_dentry->d_inode);
+		return (ssize_t)(p - buffer);
+	}
+}
+
+static int
+random_ioctl(struct inode * inode, struct file * file,
+	     unsigned int cmd, unsigned long arg)
+{
+	int size, ent_count;
+	int __user *p = (int __user *)arg;
+	int retval;
+	
+	switch (cmd) {
+	case RNDGETENTCNT:
+		ent_count = random_state->entropy_count;
+		if (put_user(ent_count, p))
+			return -EFAULT;
+		return 0;
+	case RNDADDTOENTCNT:
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		if (get_user(ent_count, p))
+			return -EFAULT;
+		credit_entropy_store(random_state, ent_count);
+		/*
+		 * Wake up waiting processes if we have enough
+		 * entropy.
+		 */
+		if (random_state->entropy_count >= random_read_wakeup_thresh
+			&&  random_state->reseed_count != 0)
+			wake_up_interruptible(&random_read_wait);
+		return 0;
+	case RNDGETPOOL:
+		/* can't do this anymore */
+		return 0;
+	case RNDADDENTROPY:
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		if (get_user(ent_count, p++))
+			return -EFAULT;
+		if (ent_count < 0)
+			return -EINVAL;
+		if (get_user(size, p++))
+			return -EFAULT;
+		retval = random_write(file, (const char __user *) p,
+				      size, &file->f_pos);
+		if (retval < 0)
+			return retval;
+		credit_entropy_store(random_state, ent_count);
+		/*
+		 * Wake up waiting processes if we have enough
+		 * entropy.
+		 */
+		if (random_state->entropy_count >= random_read_wakeup_thresh
+			&&  random_state->reseed_count != 0)
+			wake_up_interruptible(&random_read_wait);
+		return 0;
+	case RNDZAPENTCNT:
+		/* Can't do this anymore */
+		return 0;
+	case RNDCLEARPOOL:
+		/* Can't to this anymore */
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+struct file_operations random_fops = {
+	.read		= random_read,
+	.write		= random_write,
+	.poll		= random_poll,
+	.ioctl		= random_ioctl,
+};
+
+struct file_operations urandom_fops = {
+	.read		= urandom_read,
+	.write		= random_write,
+	.ioctl		= random_ioctl,
+};
+
+/***************************************************************
+ * Random UUID interface
+ * 
+ * Used here for a Boot ID, but can be useful for other kernel 
+ * drivers.
+ ***************************************************************/
+
+/*
+ * Generate random UUID
+ */
+void generate_random_uuid(unsigned char uuid_out[16])
+{
+	get_random_bytes(uuid_out, 16);
+	/* Set UUID version to 4 --- truely random generation */
+	uuid_out[6] = (uuid_out[6] & 0x0F) | 0x40;
+	/* Set the UUID variant to DCE */
+	uuid_out[8] = (uuid_out[8] & 0x3F) | 0x80;
+}
+
+EXPORT_SYMBOL(generate_random_uuid);
+
+/********************************************************************
+ *
+ * Sysctl interface
+ *
+ ********************************************************************/
+
+#ifdef CONFIG_SYSCTL
+
+#include <linux/sysctl.h>
+
+static int sysctl_poolsize;
+static int min_read_thresh, max_read_thresh;
+static int min_write_thresh, max_write_thresh;
+static char sysctl_bootid[16];
+
+static int proc_do_poolsize(ctl_table *table, int write, struct file *filp,
+			    void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	int	ret;
+
+	sysctl_poolsize = POOLBITS;
+
+	ret = proc_dointvec(table, write, filp, buffer, lenp, ppos);
+	if (ret || !write ||
+	    (sysctl_poolsize == POOLBITS))
+		return ret;
+
+	return ret; /* can't change the pool size in fortuna */
+}
+
+static int poolsize_strategy(ctl_table *table, int __user *name, int nlen,
+			     void __user *oldval, size_t __user *oldlenp,
+			     void __user *newval, size_t newlen, void **context)
+{
+	int	len;
+	
+	sysctl_poolsize = POOLBITS;
+
+	/*
+	 * We only handle the write case, since the read case gets
+	 * handled by the default handler (and we don't care if the
+	 * write case happens twice; it's harmless).
+	 */
+	if (newval && newlen) {
+		len = newlen;
+		if (len > table->maxlen)
+			len = table->maxlen;
+		if (copy_from_user(table->data, newval, len))
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
+/*
+ * These functions is used to return both the bootid UUID, and random
+ * UUID.  The difference is in whether table->data is NULL; if it is,
+ * then a new UUID is generated and returned to the user.
+ * 
+ * If the user accesses this via the proc interface, it will be returned
+ * as an ASCII string in the standard UUID format.  If accesses via the 
+ * sysctl system call, it is returned as 16 bytes of binary data.
+ */
+static int proc_do_uuid(ctl_table *table, int write, struct file *filp,
+			void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	ctl_table	fake_table;
+	unsigned char	buf[64], tmp_uuid[16], *uuid;
+
+	uuid = table->data;
+	if (!uuid) {
+		uuid = tmp_uuid;
+		uuid[8] = 0;
+	}
+	if (uuid[8] == 0)
+		generate_random_uuid(uuid);
+
+	sprintf(buf, "%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x-"
+		"%02x%02x%02x%02x%02x%02x",
+		uuid[0],  uuid[1],  uuid[2],  uuid[3],
+		uuid[4],  uuid[5],  uuid[6],  uuid[7],
+		uuid[8],  uuid[9],  uuid[10], uuid[11],
+		uuid[12], uuid[13], uuid[14], uuid[15]);
+	fake_table.data = buf;
+	fake_table.maxlen = sizeof(buf);
+
+	return proc_dostring(&fake_table, write, filp, buffer, lenp, ppos);
+}
+
+static int uuid_strategy(ctl_table *table, int __user *name, int nlen,
+			 void __user *oldval, size_t __user *oldlenp,
+			 void __user *newval, size_t newlen, void **context)
+{
+	unsigned char	tmp_uuid[16], *uuid;
+	unsigned int	len;
+
+	if (!oldval || !oldlenp)
+		return 1;
+
+	uuid = table->data;
+	if (!uuid) {
+		uuid = tmp_uuid;
+		uuid[8] = 0;
+	}
+	if (uuid[8] == 0)
+		generate_random_uuid(uuid);
+
+	if (get_user(len, oldlenp))
+		return -EFAULT;
+	if (len) {
+		if (len > 16)
+			len = 16;
+		if (copy_to_user(oldval, uuid, len) ||
+		    put_user(len, oldlenp))
+			return -EFAULT;
+	}
+	return 1;
+}
+
+ctl_table random_table[] = {
+	{
+		.ctl_name	= RANDOM_POOLSIZE,
+		.procname	= "poolsize",
+		.data		= &sysctl_poolsize,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_do_poolsize,
+		.strategy	= &poolsize_strategy,
+	},
+	{
+		.ctl_name	= RANDOM_ENTROPY_COUNT,
+		.procname	= "entropy_avail",
+		.maxlen		= sizeof(int),
+		.mode		= 0444,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= RANDOM_READ_THRESH,
+		.procname	= "read_wakeup_threshold",
+		.data		= &random_read_wakeup_thresh,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_minmax,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &min_read_thresh,
+		.extra2		= &max_read_thresh,
+	},
+	{
+		.ctl_name	= RANDOM_WRITE_THRESH,
+		.procname	= "write_wakeup_threshold",
+		.data		= &random_write_wakeup_thresh,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_minmax,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &min_write_thresh,
+		.extra2		= &max_write_thresh,
+	},
+	{
+		.ctl_name	= RANDOM_BOOT_ID,
+		.procname	= "boot_id",
+		.data		= &sysctl_bootid,
+		.maxlen		= 16,
+		.mode		= 0444,
+		.proc_handler	= &proc_do_uuid,
+		.strategy	= &uuid_strategy,
+	},
+	{
+		.ctl_name	= RANDOM_UUID,
+		.procname	= "uuid",
+		.maxlen		= 16,
+		.mode		= 0444,
+		.proc_handler	= &proc_do_uuid,
+		.strategy	= &uuid_strategy,
+	},
+	{
+		.ctl_name	= RANDOM_DIGEST_ALGO,
+		.procname	= "digest_algo",
+		.maxlen		= 16,
+		.mode		= 0444,
+		.proc_handler	= &proc_dostring,
+	},
+	{
+		.ctl_name	= RANDOM_CIPHER_ALGO,
+		.procname	= "cipher_algo",
+		.maxlen		= 16,
+		.mode		= 0444,
+		.proc_handler	= &proc_dostring,
+	},
+	{ .ctl_name = 0 }
+};
+
+static void sysctl_init_random(struct entropy_store *random_state)
+{
+	int i;
+
+	/* If the sys-admin doesn't want people to know how fast
+	 * random events are happening, he can set the read-threshhold
+	 * down to zero so /dev/random never blocks.  Default is to block.
+	 * This is for the paranoid loonies who think frequency analysis
+	 * would lead to something.
+	 */
+	min_read_thresh = 0;
+	min_write_thresh = 0;
+	max_read_thresh = max_write_thresh = POOLBITS;
+	for (i=0; random_table[i].ctl_name!=0; i++) {
+		switch (random_table[i].ctl_name) {
+		case RANDOM_ENTROPY_COUNT:
+			// If we don't want 
+#if RANDOM_NO_ENTROPY_COUNT
+			random_table[i].data = &random_state->entropy_count_bogus;
+			random_state->entropy_count_bogus = POOLBITS;
+#else
+			random_table[i].data = &random_state->entropy_count;
+#endif
+		break;
+
+		case RANDOM_DIGEST_ALGO:
+			random_table[i].data = (void*)random_state->digestAlgo;
+		break;
+
+		case RANDOM_CIPHER_ALGO:
+			random_table[i].data = (void*)random_state->cipherAlgo;
+		break;
+
+		default:
+		break;
+		}
+	}
+}
+#endif 	/* CONFIG_SYSCTL */
+
+/********************************************************************
+ *
+ * Random funtions for networking
+ *
+ ********************************************************************/
+
+/*
+ * TCP initial sequence number picking.  This uses the random number
+ * generator to pick an initial secret value.  This value is encrypted
+ * with the TCP endpoint information to provide a unique starting point
+ * for each pair of TCP endpoints.  This defeats attacks which rely on
+ * guessing the initial TCP sequence number.  This algorithm was
+ * suggested by Steve Bellovin, modified by Jean-Luc Cooke.
+ *
+ * Using a very strong hash was taking an appreciable amount of the total
+ * TCP connection establishment time, so this is a weaker hash,
+ * compensated for by changing the secret periodically.  This was changed
+ * again by Jean-Luc Cooke to use AES256-CBC encryption which is faster
+ * still (see `/usr/bin/openssl speed md4 sha1 aes`)
+ */
+
+/* This should not be decreased so low that ISNs wrap too fast. */
+#define REKEY_INTERVAL	(300*HZ)
+/*
+ * Bit layout of the tcp sequence numbers (before adding current time):
+ * bit 24-31: increased after every key exchange
+ * bit 0-23: hash(source,dest)
+ *
+ * The implementation is similar to the algorithm described
+ * in the Appendix of RFC 1185, except that
+ * - it uses a 1 MHz clock instead of a 250 kHz clock
+ * - it performs a rekey every 5 minutes, which is equivalent
+ * 	to a (source,dest) tulple dependent forward jump of the
+ * 	clock by 0..2^(HASH_BITS+1)
+ *
+ * Thus the average ISN wraparound time is 68 minutes instead of
+ * 4.55 hours.
+ *
+ * SMP cleanup and lock avoidance with poor man's RCU.
+ * 			Manfred Spraul <manfred@colorfullife.com>
+ * 		
+ */
+#define COUNT_BITS	8
+#define COUNT_MASK	( (1<<COUNT_BITS)-1)
+#define HASH_BITS	24
+#define HASH_MASK	( (1<<HASH_BITS)-1 )
+
+static spinlock_t ip_lock = SPIN_LOCK_UNLOCKED;
+static unsigned int ip_cnt, network_count;
+
+static void __check_and_rekey(time_t time)
+{
+	u8 tmp[RANDOM_MAX_KEY_SIZE];
+	spin_lock_bh(&ip_lock);
+
+	get_random_bytes(tmp, random_state->keysize);
+	crypto_cipher_setkey(random_state->networkCipher,
+					(const u8*)tmp,
+					random_state->keysize);
+	random_state->networkCipher_ready = 1;
+	network_count = (ip_cnt & COUNT_MASK) << HASH_BITS;
+	mb();
+	ip_cnt++;
+
+	spin_unlock_bh(&ip_lock);
+	return;
+}
+
+static inline void check_and_rekey(time_t time)
+{
+	static time_t rekey_time=0;
+
+	rmb();
+	if (!rekey_time || (time - rekey_time) > REKEY_INTERVAL) {
+		__check_and_rekey(time);
+		rekey_time = time;
+	}
+
+	return;
+}
+
+#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
+__u32 secure_tcpv6_sequence_number(__u32 *saddr, __u32 *daddr,
+				   __u16 sport, __u16 dport)
+{
+	struct timeval 	tv;
+	__u32		seq;
+	__u32		tmp[4];
+	struct scatterlist sgtmp[1];
+
+	/*
+	 * The procedure is the same as for IPv4, but addresses are longer.
+	 * Thus we must use two AES operations.
+	 */
+
+	do_gettimeofday(&tv);	/* We need the usecs below... */
+	check_and_rekey(tv.tv_sec);
+
+	sgtmp[0].page = virt_to_page(tmp);
+	sgtmp[0].offset = offset_in_page(tmp);
+	sgtmp[0].length = random_state->blocksize;
+
+	/*
+	 * AES256 is 2.5 times faster then MD4 by openssl tests.
+	 * We can afford to encrypt 2 block in CBC with
+	 * and IV={(sport)<<16 | dport, 0, 0, 0}
+	 *
+	 * seq = ct[0], ct = Enc-CBC(Key, {ports}, {daddr, saddr});
+	 *                 = Enc(Key, saddr xor Enc(Key, daddr))
+	 */ 
+	
+	/* PT0 = daddr */
+	memcpy(tmp, daddr, random_state->blocksize);
+	/* IV = {ports,0,0,0} */
+	tmp[0] ^= (sport<<16) | dport;
+	crypto_cipher_encrypt(random_state->networkCipher, sgtmp, sgtmp,
+		random_state->blocksize);
+	/* PT1 = saddr */
+	random_state->networkCipher->crt_cipher.cit_xor_block((u8*)tmp,
+		(const u8*)saddr);
+	crypto_cipher_encrypt(random_state->networkCipher, sgtmp, sgtmp,
+		random_state->blocksize);
+
+	seq = tmp[0];
+	seq += network_count;
+	seq += tv.tv_usec + tv.tv_sec*1000000;
+
+	return seq;
+}
+EXPORT_SYMBOL(secure_tcpv6_sequence_number);
+
+__u32 secure_ipv6_id(__u32 *daddr)
+{
+	__u32 tmp[4];
+	struct scatterlist sgtmp[1];
+
+	check_and_rekey(get_seconds());
+
+	memcpy(tmp, daddr, random_state->blocksize);
+	sgtmp[0].page = virt_to_page(tmp);
+	sgtmp[0].offset = offset_in_page(tmp);
+	sgtmp[0].length = random_state->blocksize;
+
+	/* id = tmp[0], tmp = Enc(Key, daddr); */
+	crypto_cipher_encrypt(random_state->networkCipher, sgtmp, sgtmp,
+		random_state->blocksize);
+
+	return tmp[0];
+}
+
+EXPORT_SYMBOL(secure_ipv6_id);
+#endif
+
+
+__u32 secure_tcp_sequence_number(__u32 saddr, __u32 daddr,
+				 __u16 sport, __u16 dport)
+{
+	struct timeval 	tv;
+	__u32		seq;
+	__u32 tmp[4];
+	struct scatterlist sgtmp[1];
+
+	/*
+	 * Pick a random secret every REKEY_INTERVAL seconds.
+	 */
+	do_gettimeofday(&tv);	/* We need the usecs below... */
+	check_and_rekey(tv.tv_sec);
+
+	/*
+	 *  Pick a unique starting offset for each TCP connection endpoints
+	 *  (saddr, daddr, sport, dport).
+	 *  Note that the words are placed into the starting vector, which is 
+	 *  then mixed with a partial MD4 over random data.
+	 */
+	/*
+	 * AES256 is 2.5 times faster then MD4 by openssl tests.
+	 * We can afford to encrypt 1 block
+	 *
+	 * seq = ct[0], ct = Enc(Key, {(sport<<16)|dport, daddr, saddr, 0})
+	 */ 
+	
+	tmp[0] = (sport<<16) | dport;
+	tmp[1] = daddr;
+	tmp[2] = saddr;
+	tmp[3] = 0;
+	sgtmp[0].page = virt_to_page(tmp);
+	sgtmp[0].offset = offset_in_page(tmp);
+	sgtmp[0].length = random_state->blocksize;
+	crypto_cipher_encrypt(random_state->networkCipher, sgtmp, sgtmp,
+		random_state->blocksize);
+
+	seq = tmp[0];
+	seq += network_count;
+	/*
+	 *	As close as possible to RFC 793, which
+	 *	suggests using a 250 kHz clock.
+	 *	Further reading shows this assumes 2 Mb/s networks.
+	 *	For 10 Mb/s Ethernet, a 1 MHz clock is appropriate.
+	 *	That's funny, Linux has one built in!  Use it!
+	 *	(Networks are faster now - should this be increased?)
+	 */
+	seq += tv.tv_usec + tv.tv_sec*1000000;
+
+#if 0
+	printk("init_seq(%lx, %lx, %d, %d) = %d\n",
+	       saddr, daddr, sport, dport, seq);
+#endif
+	return seq;
+}
+
+EXPORT_SYMBOL(secure_tcp_sequence_number);
+
+/*  The code below is shamelessly stolen from secure_tcp_sequence_number().
+ *  All blames to Andrey V. Savochkin <saw@msu.ru>.
+ *  Changed by Jean-Luc Cooke <jlcooke@certainkey.com> to use AES & C.A.P.I.
+ */
+__u32 secure_ip_id(__u32 daddr)
+{
+	struct scatterlist sgtmp[1];
+	__u32 tmp[4];
+
+	check_and_rekey(get_seconds());
+
+	/*
+	 *  Pick a unique starting offset for each IP destination.
+	 *  id = ct[0], ct = Enc(Key, {daddr,0,0,0});
+	 */
+	tmp[0] = daddr;
+	tmp[1] = 0;
+	tmp[2] = 0;
+	tmp[3] = 0;
+	sgtmp[0].page = virt_to_page(tmp);
+	sgtmp[0].offset = offset_in_page(tmp);
+	sgtmp[0].length = random_state->blocksize;
+
+	crypto_cipher_encrypt(random_state->networkCipher, sgtmp, sgtmp,
+		random_state->blocksize);
+
+	return tmp[0];
+}
+
+u32 secure_tcp_port_ephemeral(__u32 saddr, __u32 daddr, __u16 dport)
+{
+	struct scatterlist sgtmp[1];
+	__u32 tmp[4];
+
+	check_and_rekey(get_seconds());
+
+	/*
+	 *  Pick a unique starting offset for each ephemeral port search
+	 *  id = ct[0], ct = Enc(Key, {saddr,daddr,dport,0});
+	 */
+	memset(tmp, 0, sizeof(tmp));
+	tmp[0] = saddr;
+	tmp[1] = daddr;
+	tmp[2] = dport;
+	tmp[3] = 0;
+	sgtmp[0].page = virt_to_page(tmp);
+	sgtmp[0].offset = offset_in_page(tmp);
+	sgtmp[0].length = random_state->blocksize;
+
+	crypto_cipher_encrypt(random_state->networkCipher, sgtmp, sgtmp,
+		random_state->blocksize);
+
+	return tmp[0];
+}
+
+#ifdef CONFIG_SYN_COOKIES
+/*
+ * Secure SYN cookie computation. This is the algorithm worked out by
+ * Dan Bernstein and Eric Schenk.
+ *
+ * For linux I implement the 1 minute counter by looking at the jiffies clock.
+ * The count is passed in as a parameter, so this code doesn't much care.
+ * 
+ * SYN cookie (and seq# & id#) Changed in 2004 by Jean-Luc Cooke
+ * <jlcooke@certainkey.com> to use the C.A.P.I. and AES256.
+ */
+
+#define COOKIEBITS 24	/* Upper bits store count */
+#define COOKIEMASK (((__u32)1 << COOKIEBITS) - 1)
+
+__u32 secure_tcp_syn_cookie(__u32 saddr, __u32 daddr, __u16 sport,
+		__u16 dport, __u32 sseq, __u32 count, __u32 data)
+{
+	struct scatterlist sg[1];
+	__u32   tmp[4];
+
+	/*
+	 * Compute the secure sequence number.
+	 *
+	 * Output is the 32bit tag of a CBC-MAC of
+	 * PT={count,0,0,0} with IV={addr,daddr,sport|dport,sseq}
+	 *   cookie = {<8bit count>,
+	 *             truncate_24bit(
+	 *               Encrypt(Sec, {saddr,daddr,sport|dport,sseq})
+	 *             )
+	 *            }
+	 *
+	 * DJB wrote (http://cr.yp.to/syncookies/archive) about how to do this
+	 * with hash algorithms.
+	 * - we can replace two SHA1s used in the previous kernel with 1 AES
+	 *   and make things 5x faster
+	 * - I'd like to propose we remove the use of two whittenings with a
+	 *   single operation since we were only using addition modulo 2^32 of
+	 *   all these values anyways.  Not to mention the hashs differ only in
+	 *   that the second processes more data... why drop the first hash?
+	 *   We did learn that addition is commutative and associative long ago.
+	 * - by replacing two SHA1s and addition modulo 2^32 with encryption of
+	 *   a 32bit value using CAPI we've made it 1,000,000,000 times easier
+	 *   to understand what is going on.
+	 */
+
+	tmp[0] = saddr;
+	tmp[1] = daddr;
+	tmp[2] = (sport << 16) + dport;
+	tmp[3] = sseq;
+
+	sg[0].page = virt_to_page(tmp);
+	sg[0].offset = offset_in_page(tmp);
+	sg[0].length = random_state->blocksize;
+	if (!random_state->networkCipher_ready) {
+		check_and_rekey(get_seconds());
+	}
+	/* tmp[]/sg[0] = Enc(Sec, {saddr,daddr,sport|dport,sseq}) */
+	crypto_cipher_encrypt(random_state->networkCipher, sg, sg,
+		random_state->blocksize);
+
+	/* cookie = CTR encrypt of 8-bit-count and 24-bit-data */
+printk("random: secure_tcp_syn_cookie cook=%x", tmp[0] ^ ( (count << COOKIEBITS) | (data & COOKIEMASK) ) );
+	return tmp[0] ^ ( (count << COOKIEBITS) | (data & COOKIEMASK) );
+}
+
+/*
+ * This retrieves the small "data" value from the syncookie.
+ * If the syncookie is bad, the data returned will be out of
+ * range.  This must be checked by the caller.
+ *
+ * The count value used to generate the cookie must be within
+ * "maxdiff" if the current (passed-in) "count".  The return value
+ * is (__u32)-1 if this test fails.
+ */
+__u32 check_tcp_syn_cookie(__u32 cookie, __u32 saddr, __u32 daddr, __u16 sport,
+		__u16 dport, __u32 sseq, __u32 count, __u32 maxdiff)
+{
+	struct scatterlist sg[1];
+	__u32 tmp[4], thiscount, diff;
+
+printk("random: check_tcp_syn_cookie state=%p", random_state);
+	if (random_state == NULL  ||  !random_state->networkCipher_ready)
+		return (__u32)-1;       /* Well, duh! */
+
+	tmp[0] = saddr;
+	tmp[1] = daddr;
+	tmp[2] = (sport << 16) + dport;
+	tmp[3] = sseq;
+	sg[0].page = virt_to_page(tmp);
+	sg[0].offset = offset_in_page(tmp);
+	sg[0].length = random_state->blocksize;
+	crypto_cipher_encrypt(random_state->networkCipher, sg, sg,
+		random_state->blocksize);
+
+	/* CTR decrypt the cookie */
+	cookie ^= tmp[0];
+
+	/* top 8 bits are 'count' */
+	thiscount = cookie >> COOKIEBITS;
+
+	diff = count - thiscount;
+printk("random: check_tcp_syn_cookie diff=%x maxdiff=%x", diff, maxdiff);
+	if (diff >= maxdiff)
+		return (__u32)-1;
+
+	/* bottom 24 bits are 'data' */
+	return cookie & COOKIEMASK;
+}
+#endif
--- linux-2.6.11.6/drivers/char/Makefile	2005-03-25 22:28:37.000000000 -0500
+++ linux-2.6.11.6-fort/drivers/char/Makefile	2005-03-30 09:04:49.000000000 -0500
@@ -7,7 +7,13 @@
 #
 FONTMAPFILE = cp437.uni
 
-obj-y	 += mem.o random.o tty_io.o n_tty.o tty_ioctl.o
+obj-y	 += mem.o
+ifeq ($(CONFIG_CRYPTO_RANDOM_FORTUNA),y)
+  obj-y	 += random-fortuna.o
+else
+  obj-y	 += random.o
+endif
+obj-y	 += tty_io.o n_tty.o tty_ioctl.o
 
 obj-$(CONFIG_LEGACY_PTYS)	+= pty.o
 obj-$(CONFIG_UNIX98_PTYS)	+= pty.o
--- linux-2.6.11.6/include/linux/sysctl.h	2005-03-25 22:28:22.000000000 -0500
+++ linux-2.6.11.6-fort/include/linux/sysctl.h	2005-03-30 09:04:49.000000000 -0500
@@ -202,7 +202,9 @@
 	RANDOM_READ_THRESH=3,
 	RANDOM_WRITE_THRESH=4,
 	RANDOM_BOOT_ID=5,
-	RANDOM_UUID=6
+	RANDOM_UUID=6,
+	RANDOM_DIGEST_ALGO=7,
+	RANDOM_CIPHER_ALGO=8
 };
 
 /* /proc/sys/kernel/pty */

--oFbHfjnMgUMsrGjO--
