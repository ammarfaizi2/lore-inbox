Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268076AbUJTAC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268076AbUJTAC0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 20:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270219AbUJSXqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:46:07 -0400
Received: from [211.58.254.17] ([211.58.254.17]:17025 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S270101AbUJSWwJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:52:09 -0400
Date: Wed, 20 Oct 2004 07:52:00 +0900
Cc: linux-kernel@vger.kernel.org
Subject: [RFC and PATCH] per-device parameter support
Message-ID: <20041019225159.GA27322@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: Tejun Heo <tj@home-tj.org>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, guys.

 I've implemented devparam facility which supports per-device device,
bus, class specific parameters.  This should solve the random device
or device parameter limits of many drivers (mainly network drivers).

 It's backward compatible with the old way of specifying device
parameters (that is, array module parameter) so drivers can be
converted without user-visible changes.  Also, to reduce code
duplications in drivers, bit flag helpers and range check are added to
module/devparam.

 I think it's almost done but I'm not sure if I'm on the right track
so I want to get some responses.  I'm posting three patches and
devparam test module source codes.  The second patch is quite chunky
and contains a number of changes.  I'll split it later.

 Reading devparam.txt included in devparam patch (also attached in
this mail), velocity_dp patch and dp test module source codes should
suffice to know about devparam.

 1. vector patch        : a generic vector which can be expanded/shrunk
                        dynamically.
 2. devparam patch      : device parameter patch including all module/dev
                        param changes.  Also contains devparam
                        documentation.
 3. velocity_dp patch   : a patch which changes via-velocity driver to
                        use devparam facility.
 4. dptest		: devparam test modules including dp_bus, dp_class,
                        dp_drv, dp_dev.  These modules show pretty much
                        everything devparam can do.

http://home-tj.org/devparam/vector-2.6.9-rc4.patch
http://home-tj.org/devparam/devparam-2.6.9-rc4.patch
http://home-tj.org/devparam/velocity_dp-2.6.9-rc4.patch
http://home-tj.org/devparam/dptest.tar.gz

Thanks.

@ This is the second posting of this message.  I attached all four
files in the first message and the mail seems to be dropped or clogged
up somewhere.  It's not showing up anywhere after 12hours.  :-(

-- 
tejun

----------------------------------
Document/driver-model/devparam.txt

Per-Device Parameter

Tejun Heo  <tj@home-tj.org>

19 October 2004


 Intro
 =====

 Per-device parameter wasn't supported by Linux driver model
previously.  It was usually done using the moduleparam facility.  As
the name suggests, moduleparam implements per-module parameters and
drivers usually used fixed-size array of per-module paramters to
implement per-device parameters.  This results in unnecessary
duplication of codes, variation in usage and random limits on the
number of supported devices or devices which a user can specify
parameters for.  Devparam integrates per-device parameter support into
the driver model to solve these issues.

 Devparam aims to

 1. reduce duplicated parameter handling codes from drivers
 2. retain user-visible syntax for converted drivers.
 3. support per-device device, bus and auxiliary (possibly classes)
    parameter sets.
 4. remove hard-coded random limits
 5. support sysfs access to per-device paramters


 Overview
 ========

 Parameters are organized into parameter sets or paramsets.  Each
paramset is represented by a structure (e.g. struct my_paramset).  A
paramset definition describes the paramset to the driver model - what
it contains, how to parse each parameter and so on.

 A device driver passes paramset_defs it wants to use to the driver
model while registering the driver, and before the driver is attached
to a device, the driver model parses user supplied parameters and
supplies the requested paramsets.

 There are three categories of paramsets.

 1. DEV paramset

 These are device specific parameters used by the driver.  This
category will include most parameters currently used by drivers.
Examples would be stuff like size of tx/rx descriptor array, hardware
checksum enable/disable option for network drivers.


 2. BUS paramset

 There are bus specific parameters.  If a bus driver wants to accept
some common paramters for all devices on the bus, the driver will
supply the bus paramset definition and all device drivers for the bus
will accept bus parameters.  Examples would be PCI command register
setting, PCIe QoS setting and so on.


 3. AUX paramsets

 Auxiliary paramsets.  A driver can use any number of auxiliary
paramset definitions to the driver-model.  For example, if the block
device layer wants to accept some common set of parameters, it defines
a paramset_def and block device drivers can use the paramset_def to
accept the common parameters.  Once modified to use the facility, the
content of the paramset_def or paramset doesn't matter to specific
device drivers, so block layer can modify its paramset_def without
changing individual device drivers.


 Using devparam
 ==============

 Paramset definition is defined using DEFINE_DEVICE_PARAMSET and
DEVICE_PARAM_* macros and passed to the driver-model via the
*_paramset_def fields of struct device_driver or struct bus_type.
It's best explained with an example.  The following code snippet is
taken from a pseudo driver dp_drv which is written to test devparam.


struct dp_drv_paramset {
	int n;
	char *p, s[32];
	long opts[4];
	int optcnt;
};

static DEFINE_DEVICE_PARAMSET(dp_drv_paramset_def, struct dp_drv_paramset,
	DEVICE_PARAM_RANGED(n, int, 0, 16, NULL, 0400,
		"drv ranged integer parameter n (0-16)")
	DEVICE_PARAM(p, charp, "asdf", 0400,
		"drv charp parameter p")
	DEVICE_PARAM_STRING(s, "fdsa", 0400,
		"drv string paramter s")
	DEVICE_PARAM_ARRAY_RANGED(opts, long, optcnt, -128, 128, "1,2,3", 0400,
		"drv ranged long array opts (-128-128)")
);

static struct dp_driver my_drv = {
	...
	.driver.dev_paramset_def	= &dp_drv_paramset_def,
	...
};

static int dp_drv_probe(struct device *dev)
{
	struct dp_drv_paramset *params = dev->params.dev;
	...
}


 As you can see, the usage is very similar to that of moduleparam;
actually, most of devparam is built using moduleparam facilities.
However, as our parameter definitions aren't global but belong to a
paramset, there's an surrounding macro which specifies the paramset.

- DEFINE_DEVICE_PARAMSET(Name, Type, Paramdefs) macro

	Defines a struct device_paramset_def @Name which contains
	parameters described by @Paramdefs.  Each parameter definition
	in @Paramdefs describes how to handle a parameter which is
	contained in a @Type variable.

- DEVICE_PARAM_*() macros

	Syntax is almost identical to module_param_*() macros defined
	in moduleparam.h.  There are three differences.  The first is
	that instead of referring directly to a variable to be set,
	the field name inside @Type of enclosing
	DEFINE_DEVICE_PARAMSET is used.  The second is that there's an
	extra argument @Dfl which is a string containing the default
	value to use when the user didn't specify the parameter.
	The last is the additional argument @Desc which serves the
	same purpose as MODULE_PARAM_DESC().


 When attaching a device, its paramset structures are allocated and
cleared with zero, and for each defined parameter, set function is
called with user supplied argument if it's available or the default
string (if the default string is also NULL, set function isn't
called).

 Currently, device parameters are passed as comma-separated values via
moduleparam facility (the first value is for the first device which
gets attached to the driver, the second value for the second device
and so on).  In parameter strings, '\' escapes the following
character, so by using "\," strings containing commas or
comma-separated arrays can be specified.  To ease array specification,
':' is also accepted as nested array separator.

 Parameters in the above example can be specified

 I. as kernel boot parameters (when the driver is compiled into the kernel)

	EX) dp_drv.n=1,2,1 dp_drv.opts="3:2:1,4:3:2\,5"

		 n	p	s		opts		opts_cnt
	1st dev: 1	"asdf"	"fdsa"		{ 3, 2, 1, 0 }	3
	2nd dev: 2	"asdf"	"fdsa"		{ 4, 3, 2, 5 }	4
	3rd dev: 1	"asdf"	"fdsa"		{ 1, 2, 3, 0 }	3
	4th-Nth: 0	"asdf"	"fdsa"		{ 1, 2, 3, 0 }	3

 II. as module parameters (when the driver is built as a module)

	EX) modprobe dp_drv p=zxcv,fdsa s="mung mung,as\,df" opts=4,2,1

		 n	p	s		opts		opts_cnt
	1st dev: 0	"zxcv"	"mung mung"	{ 4, 0, 0, 0 }	1
	2nd dev: 0	"fdsa"	"as,df"		{ 2, 0, 0, 0 }	1
	3rd dev: 0	"asdf"	"fdsa"		{ 1, 0, 0, 0 }	1
	4th-Nth: 0	"asdf"	"fdsa"		{ 1, 2, 3, 0 }	3
