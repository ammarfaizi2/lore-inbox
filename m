Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030323AbWHHWUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030323AbWHHWUs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 18:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030326AbWHHWUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 18:20:48 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:44947 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030323AbWHHWUr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 18:20:47 -0400
Date: Tue, 8 Aug 2006 18:20:41 -0400
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       rubini@vision.unipv.it, device@lanana.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Chardev checking of overlapping ranges is incorrect.
Message-ID: <20060808222041.GA9708@kvasir.watson.ibm.com>
References: <20060807225555.GQ10638@austin.ibm.com> <20060807234753.ff21eb29.akpm@osdl.org> <20060808205258.GA6111@kvasir.watson.ibm.com> <20060808213331.GW10638@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060808213331.GW10638@austin.ibm.com>
User-Agent: Mutt/1.5.12-2006-07-14
From: Amos Waterland <apw@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2006 at 04:33:31PM -0500, Linas Vepstas wrote:
> On Tue, Aug 08, 2006 at 04:52:58PM -0400, Amos Waterland wrote:
> > Hi Andrew.  It does fix the original bug, but it introduces the bug that
> > Linas pointed out.  After looking at Linas' fix and finding an
> > off-by-one error in his code, 
> 
> Ooops
> 
> > Can you please back out my original patch and use this instead?  I have
> > run it through the test harness and I am much more confident in its
> > correctness.  Linas can you take a look at this and make sure you agree?
> 
> Actually, there's still a problem. An added device could still 
> overlap with a previously added device and not be detected. 
> We should keep the devices in order, and check that the region
> fits in between the last and the next device.  So, for example,
> the following will make the latest patch accept an invalid region:
> 
> First, add maj=x, minor=64-127
> Next, add  maj=x, minor=0-63
> Next, add  maj=x, minor=32-63
> 
> When going to insert the third chardev, the for-loop will catch 
> the first elt in the chain, do the bounds-check, and add it
> without complaint.  I'll try a patch shortly.

Are you sure?  I do not see how that can happen.  Below is the harness
with your proposed sequence: the last patch that I posted properly
rejects it.

The harness is just a stand-alone C program, you can compile it on any
machine and test your sequence: maybe I misunderstood the minor ranges
you intended.

---

$  gcc -g -O0 -Wall -Werror test-register.c -o test-register
$ ./test-register 
OVERLAPPING MINORS
  NAME     MIN    MAX  DRIVER   PASS
 linus:      0      3   first     OK
 linus:      1      4  second   FAIL
  amos:      0      3   first     OK
  amos:     -1     -1    NULL     OK
andrew:      0      3   first     OK
andrew:     -1     -1    NULL     OK
 linas:      0      3   first     OK
 linas:     -1     -1    NULL     OK
 amos2:      0      3   first     OK
 amos2:     -1     -1    NULL     OK

NON-OVERLAPPING MINORS
  NAME     MIN    MAX  DRIVER   PASS
 linus:    128    130   first     OK
 linus:      3      5  second     OK
  amos:    128    130   first     OK
  amos:     -1     -1    NULL   FAIL
andrew:    128    130   first     OK
andrew:     -1     -1    NULL   FAIL
 linas:    128    130   first     OK
 linas:      3      5  second     OK
 amos2:    128    130   first     OK
 amos2:      3      5  second     OK

CORNER CASES
  NAME     MIN    MAX  DRIVER   PASS
 linas:      0      2   first     OK
 linas:     10     12  second     OK
 linas:      5      7   third     OK
 linas:     -1     -1    NULL     OK
 linas:     -1     -1    NULL     OK
 linas:     -1     -1    NULL   FAIL
 linas:     13     13 seventh     OK
 amos2:      0      2   first     OK
 amos2:     10     12  second     OK
 amos2:      5      7   third     OK
 amos2:     -1     -1    NULL     OK
 amos2:     -1     -1    NULL     OK
 amos2:      9      9   sixth     OK
 amos2:     13     13 seventh     OK
 amos2:     64    127  64-127     OK
 amos2:      0     63    0-63     OK
 amos2:     -1     -1    NULL     OK

---

#include <string.h>
#include <stdio.h>
#include <stdlib.h>

#define CHRDEV_MAJOR_HASH_SIZE 255
#define GFP_KERNEL 0
#define ENOMEM 12
#define EBUSY 16
#define MAX_ERRNO 4095
#define SHOULD_PASS 0
#define SHOULD_FAIL 1
#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
#define IS_ERR_VALUE(x) ((x) >= (unsigned long)-MAX_ERRNO)

struct mutex { int count; } chrdevs_lock;
static struct char_device_struct {
        struct char_device_struct *next;
        unsigned int major;
        unsigned int baseminor;
        int minorct;
        char name[64];
} *chrdevs[CHRDEV_MAJOR_HASH_SIZE];

long IS_ERR(const void *ptr) { return IS_ERR_VALUE((unsigned long)ptr); }
static inline void *ERR_PTR(long error) { return (void *) error; }
void *kzalloc(size_t size, int flags) { return calloc(1, size); }
void kfree(const void *p) { return; }
int major_to_index(int index) { return index; }
void inline mutex_lock(struct mutex *lock) { return; }
void inline mutex_unlock(struct mutex *lock) { return; }

static struct char_device_struct *
linus__register_chrdev_region(unsigned int major, unsigned int baseminor,
  			      int minorct, const char *name)
{
	struct char_device_struct *cd, **cp;
	int ret = 0;
	int i;

	cd = kzalloc(sizeof(struct char_device_struct), GFP_KERNEL);
	if (cd == NULL)
		return ERR_PTR(-ENOMEM);

	mutex_lock(&chrdevs_lock);

	/* temporary */
	if (major == 0) {
		for (i = ARRAY_SIZE(chrdevs)-1; i > 0; i--) {
			if (chrdevs[i] == NULL)
				break;
		}

		if (i == 0) {
			ret = -EBUSY;
			goto out;
		}
		major = i;
		ret = major;
	}

	cd->major = major;
	cd->baseminor = baseminor;
	cd->minorct = minorct;
	strncpy(cd->name,name, 64);

	i = major_to_index(major);

	for (cp = &chrdevs[i]; *cp; cp = &(*cp)->next)
		if ((*cp)->major > major ||
		    ((*cp)->major == major && (*cp)->baseminor >= baseminor))
			break;
	if (*cp && (*cp)->major == major &&
	    (*cp)->baseminor < baseminor + minorct) {
		ret = -EBUSY;
		goto out;
	}
	cd->next = *cp;
	*cp = cd;
	mutex_unlock(&chrdevs_lock);
	return cd;
out:
	mutex_unlock(&chrdevs_lock);
	kfree(cd);
	return ERR_PTR(ret);
}

static struct char_device_struct *
amos__register_chrdev_region(unsigned int major, unsigned int baseminor,
  			     int minorct, const char *name)
{
	struct char_device_struct *cd, **cp;
	int ret = 0;
	int i;

	cd = kzalloc(sizeof(struct char_device_struct), GFP_KERNEL);
	if (cd == NULL)
		return ERR_PTR(-ENOMEM);

	mutex_lock(&chrdevs_lock);

	/* temporary */
	if (major == 0) {
		for (i = ARRAY_SIZE(chrdevs)-1; i > 0; i--) {
			if (chrdevs[i] == NULL)
				break;
		}

		if (i == 0) {
			ret = -EBUSY;
			goto out;
		}
		major = i;
		ret = major;
	}

	cd->major = major;
	cd->baseminor = baseminor;
	cd->minorct = minorct;
	strncpy(cd->name,name, 64);

	i = major_to_index(major);

	for (cp = &chrdevs[i]; *cp; cp = &(*cp)->next)
		if ((*cp)->major > major ||
		    ((*cp)->major == major &&
		     (((*cp)->baseminor >= baseminor) ||
		      ((*cp)->baseminor + (*cp)->minorct > baseminor))))
			break;
	if (*cp && (*cp)->major == major &&
	    (((*cp)->baseminor < baseminor + minorct) ||
	     ((*cp)->baseminor + (*cp)->minorct > baseminor))) {
		ret = -EBUSY;
		goto out;
	}
	cd->next = *cp;
	*cp = cd;
	mutex_unlock(&chrdevs_lock);
	return cd;
out:
	mutex_unlock(&chrdevs_lock);
	kfree(cd);
	return ERR_PTR(ret);
}

static struct char_device_struct *
andrew__register_chrdev_region(unsigned int major, unsigned int baseminor,
			       int minorct, const char *name)
{
	struct char_device_struct *cd, **cp;
	int ret = 0;
	int i;

	cd = kzalloc(sizeof(struct char_device_struct), GFP_KERNEL);
	if (cd == NULL)
		return ERR_PTR(-ENOMEM);

	mutex_lock(&chrdevs_lock);

	/* temporary */
	if (major == 0) {
		for (i = ARRAY_SIZE(chrdevs)-1; i > 0; i--) {
			if (chrdevs[i] == NULL)
				break;
		}

		if (i == 0) {
			ret = -EBUSY;
			goto out;
		}
		major = i;
		ret = major;
	}

	cd->major = major;
	cd->baseminor = baseminor;
	cd->minorct = minorct;
	strncpy(cd->name,name, 64);

	i = major_to_index(major);

	for (cp = &chrdevs[i]; *cp; cp = &(*cp)->next)
		if ((*cp)->major > major ||
		    ((*cp)->major == major &&
		     (((*cp)->baseminor >= baseminor) ||
		      ((*cp)->baseminor + (*cp)->minorct > baseminor))))
			break;
	if (*cp && (*cp)->major == major &&
	    (((*cp)->baseminor < baseminor + minorct) ||
	     ((*cp)->baseminor + (*cp)->minorct > baseminor))) {
		ret = -EBUSY;
		goto out;
	}
	cd->next = *cp;
	*cp = cd;
	mutex_unlock(&chrdevs_lock);
	return cd;
out:
	mutex_unlock(&chrdevs_lock);
	kfree(cd);
	return ERR_PTR(ret);
}

static struct char_device_struct *
linas__register_chrdev_region(unsigned int major, unsigned int baseminor,
			      int minorct, const char *name)
{
	struct char_device_struct *cd, **cp;
	int ret = 0;
	int i;

	cd = kzalloc(sizeof(struct char_device_struct), GFP_KERNEL);
	if (cd == NULL)
		return ERR_PTR(-ENOMEM);

	mutex_lock(&chrdevs_lock);

	/* temporary */
	if (major == 0) {
		for (i = ARRAY_SIZE(chrdevs)-1; i > 0; i--) {
			if (chrdevs[i] == NULL)
				break;
		}

		if (i == 0) {
			ret = -EBUSY;
			goto out;
		}
		major = i;
		ret = major;
	}

	cd->major = major;
	cd->baseminor = baseminor;
	cd->minorct = minorct;
	strncpy(cd->name,name, 64);

	i = major_to_index(major);

	for (cp = &chrdevs[i]; *cp; cp = &(*cp)->next)
		if ((*cp)->major > major ||
		    ((*cp)->major == major &&
		     (((*cp)->baseminor >= baseminor) ||
		      ((*cp)->baseminor + (*cp)->minorct > baseminor))))
			break;

	/* Check for overlap of minor ranges */
	if (*cp && (*cp)->major == major &&
	    ((((*cp)->baseminor <= baseminor) &&
		   ((*cp)->baseminor + (*cp)->minorct >= baseminor)) ||
	     (((*cp)->baseminor >= baseminor) &&
	      ((*cp)->baseminor <= baseminor+minorct)))) {
		ret = -EBUSY;
		goto out;
	}
	cd->next = *cp;
	*cp = cd;
	mutex_unlock(&chrdevs_lock);
	return cd;
out:
	mutex_unlock(&chrdevs_lock);
	kfree(cd);
	return ERR_PTR(ret);
}

static struct char_device_struct *
amos2__register_chrdev_region(unsigned int major, unsigned int baseminor,
  			      int minorct, const char *name)
{
	struct char_device_struct *cd, **cp;
	int ret = 0;
	int i;

	cd = kzalloc(sizeof(struct char_device_struct), GFP_KERNEL);
	if (cd == NULL)
		return ERR_PTR(-ENOMEM);

	mutex_lock(&chrdevs_lock);

	/* temporary */
	if (major == 0) {
		for (i = ARRAY_SIZE(chrdevs)-1; i > 0; i--) {
			if (chrdevs[i] == NULL)
				break;
		}

		if (i == 0) {
			ret = -EBUSY;
			goto out;
		}
		major = i;
		ret = major;
	}

	cd->major = major;
	cd->baseminor = baseminor;
	cd->minorct = minorct;
	strncpy(cd->name,name, 64);

	i = major_to_index(major);

	for (cp = &chrdevs[i]; *cp; cp = &(*cp)->next)
		if ((*cp)->major > major ||
		    ((*cp)->major == major && 
		     (((*cp)->baseminor >= baseminor) ||
		      ((*cp)->baseminor + (*cp)->minorct > baseminor))))
			break;

	/* Check for overlapping minor ranges.  */
	if (*cp && (*cp)->major == major) {
		int old_min = (*cp)->baseminor;
		int old_max = (*cp)->baseminor + (*cp)->minorct - 1;
		int new_min = baseminor;
		int new_max = baseminor + minorct - 1;

		/* New driver overlaps from the left.  */
		if (new_max >= old_min && new_max <= old_max) {
			ret = -EBUSY;
			goto out;
		}

		/* New driver overlaps from the right.  */
		if (new_min <= old_max && new_min >= old_min) {
			ret = -EBUSY;
			goto out;
		}
	}

	cd->next = *cp;
	*cp = cd;
	mutex_unlock(&chrdevs_lock);
	return cd;
out:
	mutex_unlock(&chrdevs_lock);
	kfree(cd);
	return ERR_PTR(ret);
}

void clear(struct char_device_struct **chrdevs)
{
	int i = 0;

	for (i = 0; i < CHRDEV_MAJOR_HASH_SIZE; i++)
		chrdevs[i] = 0x0;
}

void dump(const char *prefix, struct char_device_struct *cd, int should_fail)
{
	if (IS_ERR(cd)) {
		printf("%6s: %6i %6i %7s %6s\n", 
                       prefix, -1, -1, "NULL",
 		       should_fail ? "OK" : "FAIL");
		return;	
	}

	printf("%6s: %6i %6i %7s %6s\n", 
		prefix, cd->baseminor,  cd->baseminor + cd->minorct - 1, 
		cd->name, should_fail ? "FAIL" : "OK");
}

int main(int argc, char *argv[])
{
	struct char_device_struct *cd;

	/* First we test the case that a driver registers 0-3 and then
	 * another driver comes along and tries to take 1-4.  The second
	 * driver should be rejected.
	 */
	{
		printf("OVERLAPPING MINORS\n");
		printf("%6s  %6s %6s %7s %6s\n",
			"NAME", "MIN", "MAX", "DRIVER", "PASS");

		clear(chrdevs);
		cd = linus__register_chrdev_region(1, 0, 4, "first");
		dump("linus", cd, SHOULD_PASS);
		cd = linus__register_chrdev_region(1, 1, 4, "second");
		dump("linus", cd, SHOULD_FAIL);

		clear(chrdevs);
		cd = amos__register_chrdev_region(1, 0, 4, "first");
		dump("amos", cd, SHOULD_PASS);
		cd = amos__register_chrdev_region(1, 1, 4, "second");
		dump("amos", cd, SHOULD_FAIL);

		clear(chrdevs);
		cd = andrew__register_chrdev_region(1, 0, 4, "first");
		dump("andrew", cd, SHOULD_PASS);
		cd = andrew__register_chrdev_region(1, 1, 4, "second");
		dump("andrew", cd, SHOULD_FAIL);

		clear(chrdevs);
		cd = linas__register_chrdev_region(1, 0, 4, "first");
		dump("linas", cd, SHOULD_PASS);
		cd = linas__register_chrdev_region(1, 1, 4, "second");
		dump("linas", cd, SHOULD_FAIL);

		clear(chrdevs);
		cd = amos2__register_chrdev_region(1, 0, 4, "first");
		dump("amos2", cd, SHOULD_PASS);
		cd = amos2__register_chrdev_region(1, 1, 4, "second");
		dump("amos2", cd, SHOULD_FAIL);
	}

	/* Now we test the case that a driver registers 128-130 and then
	 * another driver comes along and asks for 3-5.  The second driver
	 * should NOT be rejected.
	 */
	{
		printf("\nNON-OVERLAPPING MINORS\n");
		printf("%6s  %6s %6s %7s %6s\n",
			"NAME", "MIN", "MAX", "DRIVER", "PASS");

		clear(chrdevs);
		cd = linus__register_chrdev_region(1, 128, 3, "first");
		dump("linus", cd, SHOULD_PASS);
		cd = linus__register_chrdev_region(1, 3, 3, "second");
		dump("linus", cd, SHOULD_PASS);

		clear(chrdevs);
		cd = amos__register_chrdev_region(1, 128, 3, "first");
		dump("amos", cd, SHOULD_PASS);
		cd = amos__register_chrdev_region(1, 3, 3, "second");
		dump("amos", cd, SHOULD_PASS);

		clear(chrdevs);
		cd = andrew__register_chrdev_region(1, 128, 3, "first");
		dump("andrew", cd, SHOULD_PASS);
		cd = andrew__register_chrdev_region(1, 3, 3, "second");
		dump("andrew", cd, SHOULD_PASS);

		clear(chrdevs);
		cd = linas__register_chrdev_region(1, 128, 3, "first");
		dump("linas", cd, SHOULD_PASS);
		cd = linas__register_chrdev_region(1, 3, 3, "second");
		dump("linas", cd, SHOULD_PASS);

		clear(chrdevs);
		cd = amos2__register_chrdev_region(1, 128, 3, "first");
		dump("amos2", cd, SHOULD_PASS);
		cd = amos2__register_chrdev_region(1, 3, 3, "second");
		dump("amos2", cd, SHOULD_PASS);
	}

	/* Since it looks like Linas' patch stacked on Amos' patch, which 
	 * is expressed as linus herein, is the correct solution, let's 
	 * hammer it with a few more corner cases.  We find that it has
	 * a false postive in the (10-12) + (9-9) case, so rewrite the code
	 * to make it clearer (called amos2 herein), which passes all the
	 * corner cases we know about.
	 */
	{
		printf("\nCORNER CASES\n");
		printf("%6s  %6s %6s %7s %6s\n",
			"NAME", "MIN", "MAX", "DRIVER", "PASS");

		clear(chrdevs);
		cd = linas__register_chrdev_region(1, 0, 3, "first");
		dump("linas", cd, SHOULD_PASS);
		cd = linas__register_chrdev_region(1, 10, 3, "second");
		dump("linas", cd, SHOULD_PASS);
		cd = linas__register_chrdev_region(1, 5, 3, "third");
		dump("linas", cd, SHOULD_PASS);
		cd = linas__register_chrdev_region(1, 6, 3, "fourth");
		dump("linas", cd, SHOULD_FAIL);
		cd = linas__register_chrdev_region(1, 9, 2, "fifth");
		dump("linas", cd, SHOULD_FAIL);
		cd = linas__register_chrdev_region(1, 9, 1, "sixth");
		dump("linas", cd, SHOULD_PASS);
		cd = linas__register_chrdev_region(1, 13, 1, "seventh");
		dump("linas", cd, SHOULD_PASS);

		clear(chrdevs);
		cd = amos2__register_chrdev_region(1, 0, 3, "first");
		dump("amos2", cd, SHOULD_PASS);
		cd = amos2__register_chrdev_region(1, 10, 3, "second");
		dump("amos2", cd, SHOULD_PASS);
		cd = amos2__register_chrdev_region(1, 5, 3, "third");
		dump("amos2", cd, SHOULD_PASS);
		cd = amos2__register_chrdev_region(1, 6, 3, "fourth");
		dump("amos2", cd, SHOULD_FAIL);
		cd = amos2__register_chrdev_region(1, 9, 2, "fifth");
		dump("amos2", cd, SHOULD_FAIL);
		cd = amos2__register_chrdev_region(1, 9, 1, "sixth");
		dump("amos2", cd, SHOULD_PASS);
		cd = amos2__register_chrdev_region(1, 13, 1, "seventh");
		dump("amos2", cd, SHOULD_PASS);

		clear(chrdevs);
		cd = amos2__register_chrdev_region(1, 64, 64, "64-127");
		dump("amos2", cd, SHOULD_PASS);
		cd = amos2__register_chrdev_region(1, 0, 64, "0-63");
		dump("amos2", cd, SHOULD_PASS);
		cd = amos2__register_chrdev_region(1, 32, 32, "32-63");
		dump("amos2", cd, SHOULD_FAIL);
	}

	return 0;
}

---

