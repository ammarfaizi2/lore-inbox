Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318418AbSGSB21>; Thu, 18 Jul 2002 21:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318420AbSGSB21>; Thu, 18 Jul 2002 21:28:27 -0400
Received: from air-2.osdl.org ([65.172.181.6]:9611 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S318418AbSGSB2T>;
	Thu, 18 Jul 2002 21:28:19 -0400
Date: Thu, 18 Jul 2002 18:28:17 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org, <greg@kroah.com>
Subject: driverfs updates, part 2
Message-ID: <Pine.LNX.4.44.0207181808220.2542-200000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="346834433-1542255995-1027042097=:2542"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--346834433-1542255995-1027042097=:2542
Content-Type: TEXT/PLAIN; charset=US-ASCII


Ok, here is the next round of driverfs updates. 

Short summary:

- move device and driver interface to driverfs into drivers/base/fs/*.c
- Implement bus_{create,remove}_file and driver_{create,remove}_file to 
  give people an interface to create files those object types in their 
  respective directories. 

  driver_{create,remove}_file are the simplest, and exist in 
  drivers/base/fs/driver.c. If people are feeling frisky, and want to 
  play, use that as an example on how to extend driverfs for other 
  subsystems and object types. 

  I'm also attaching an example 'subsystem' driver that exports 
  registration and unregistration functions that do creation and teardown 
  of driverfs directories. 

- Remove references to struct device in driverfs, making it completely
  independent of the device model core.

- Update documentation

	-pat

Please pull from 

	bk://ldm.bkbits.net/linux-2.5-driverfs-2

Note that this tree includes all the changes that I posted earlier today.         
bk://ldm.bkbits.net/linux-2.5-driverfs still exists, with only the earlier 
changes. 


This will update the following files:

 drivers/base/fs.c                      |  216 ----------------
 Documentation/filesystems/driverfs.txt |  443 ++++++++++++++++++++++++---------
 drivers/base/Makefile                  |    6 
 drivers/base/base.h                    |    7 
 drivers/base/bus.c                     |   74 -----
 drivers/base/driver.c                  |   23 -
 drivers/base/fs/Makefile               |   18 -
 drivers/base/fs/bus.c                  |  199 ++++++++++----
 drivers/base/fs/device.c               |  145 ++++++++--
 drivers/base/fs/driver.c               |   48 +++
 drivers/base/fs/fs.h                   |    7 
 drivers/base/fs/lib.c                  |  352 ++++++++++++++++++--------
 fs/driverfs/inode.c                    |   19 -
 fs/driverfs/lib.c                      |   28 +-
 include/linux/device.h                 |    5 
 include/linux/driverfs_fs.h            |    2 
 16 files changed, 938 insertions(+), 654 deletions(-)

through these ChangeSets:

<mochel@osdl.org> (02/07/18 1.755)
   Update driverfs documentation

<mochel@osdl.org> (02/07/18 1.754)
   driverfs:
   Remove all struct device references.
   Don't touch device's reference count on open() and close()

<mochel@osdl.org> (02/07/18 1.753)
   add functions for creating/removing driverfs files for device drivers

<mochel@osdl.org> (02/07/18 1.752)
   bus driver driverfs interface:
   include fs.h
   fix compile error

<mochel@osdl.org> (02/07/18 1.751)
   Move driverfs directory creation for drivers to drivers/base/fs/driver.c

<mochel@osdl.org> (02/07/18 1.750)
   Add helpers make_one_dir and remove_one_dir for ease of creating and removing driverfs directories

<mochel@osdl.org> (02/07/18 1.749)
   fixup callers of driverfs_create_file to just pass template to it (and not do own duplication of the template)

<mochel@osdl.org> (02/07/18 1.748)
   driverfs:
   - make driverfs_create_file do duplication of driver_file_entry passed in (instead of making each caller do it)

<mochel@osdl.org> (02/07/18 1.747)
   Implement bus_{create,remove}_file, to allow creation of files for bus drivers in the bus's driverfs directory

<mochel@osdl.org> (02/07/18 1.746)
   Make root bus directory dynamically allocated, like the rest of the directories in the world...

<mochel@osdl.org> (02/07/18 1.745)
   Make sure mode is set when creating bus directory

<mochel@osdl.org> (02/07/18 1.744)
   Move functions for bus drivers interfacing with driverfs from drivers/base/bus.c to drivers/base/fs/bus.c

<mochel@osdl.org> (02/07/18 1.743)
   Move interface for creating driverfs files for devices from drivers/base/fs/lib.c to drivers/base/fs/device.c

<mochel@osdl.org> (02/07/18 1.742)
   Move drivers/base/fs.c to drivers/base/fs/lib.c

<mochel@osdl.org> (02/07/18 1.741)
   driverfs:
   - remove stray references to struct device



--346834433-1542255995-1027042097=:2542
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="pubsys.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0207181828170.2542@cherise.pdx.osdl.net>
Content-Description: 
Content-Disposition: attachment; filename="pubsys.c"

LyoNCiAqIHB1YnN5cyAtIGV4cGxvdGluZyBkcml2ZXJmcyBmb3IgZnVuIGFu
ZCBwcm9maXQNCiAqDQogKiBDb3B5cmlnaHQgKGMpIDIwMDIgUGF0cmljayBN
b2NoZWwNCiAqICAgICAgICAgICAgICAgICAgICBPcGVuIFNvdXJjZSBEZXZl
bG9wbWVudCBMYWINCiAqDQogKiAgVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29m
dHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkN
CiAqICBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1
YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieQ0KICogIHRoZSBGcmVlIFNv
ZnR3YXJlIEZvdW5kYXRpb247IGVpdGhlciB2ZXJzaW9uIDIgb2YgdGhlIExp
Y2Vuc2UsIG9yDQogKiAgKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVy
c2lvbi4NCiAqDQogKiAgVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGlu
IHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsDQogKiAgYnV0IFdJ
VEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQg
d2FycmFudHkgb2YNCiAqICBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBG
T1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBTZWUgdGhlDQogKiAgR05VIEdl
bmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4NCiAqDQog
KiAgWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05V
IEdlbmVyYWwgUHVibGljIExpY2Vuc2UNCiAqICBhbG9uZyB3aXRoIHRoaXMg
cHJvZ3JhbTsgaWYgbm90LCB3cml0ZSB0byB0aGUgRnJlZSBTb2Z0d2FyZQ0K
ICogIEZvdW5kYXRpb24sIEluYy4sIDU5IFRlbXBsZSBQbGFjZSwgU3VpdGUg
MzMwLCBCb3N0b24sIE1BICAwMjExMS0xMzA3IFVTQQ0KICoNCiAqIFRoaXMg
aXMgYSBzYW1wbGUgc3Vic3lzdGVtIHRvIGlsbHVzdHJhdGUgaG93IGVhc3kg
aXQgaXMgdG8gbGF0Y2ggb24gdG8NCiAqIGRyaXZlcmZzIGFuZCBleHBsb2l0
IGl0LiBJdCBpcyB0aGUgJ3B1Yicgc3Vic3lzdGVtLiBPYmplY3RzIG9mIHR5
cGUgJ2JlZXInIA0KICogY2FuIGJlIHJlZ2lzdGVyZWQgYW5kIHVucmVnaXN0
ZXJlZCB3aXRoIHRoZSBwdWIgdmlhIGJlZXJfcmVnaXN0ZXIgYW5kIA0KICog
YmVlcl91bnJlZ2lzdGVyLg0KICogDQogKiBFdmVyeSB0aW1lIGEgYmVlciBp
cyByZWdpc3RlcmVkIHdpdGggdGhlIHB1YiBzdWJzeXN0ZW0sIGEgZGlyZWN0
b3J5IGlzDQogKiBjcmVhdGVkIGZvciBpdC4gVGhlIHB1YiBzdWJzeXN0ZW0g
Y291bGQgdGhlbiBjcmVhdGUgZmlsZXMgb24gYmVoYWxmIG9mDQogKiB0aGUg
YmVlciwgaW4gdGhlIGJlZXIncyBkaXJlY3RvcnkuIE9uY2UgdGhlIGJlZXIg
aGFzIHJlZ2lzdGVyZWQsIGl0DQogKiBjYW4gY3JlYXRlIGZpbGVzIGZvciBp
dHNlbGYgaW4gaXRzIGRpcmVjdG9yeS4gQSBzZWNvbmQsIG1vcmUgcm9idXN0
DQogKiBleGFtcGxlIHdpbGwgc3VyZWx5IGZvbGxvdy4gDQogKg0KICogQ29t
cGlsZWQgd2l0aA0KDQpDRkxBR1MgPSAtV2FsbCAtTzIgLWZvbWl0LWZyYW1l
LXBvaW50ZXIgLURNT0RVTEUgLURfX0tFUk5FTF9fDQpJRElSID0gL2hvbWUv
bW9jaGVsL3NyYy9rZXJuZWwvZGV2ZWwvbGludXgtMi41L2luY2x1ZGUNCg0K
cHVic3lzLm86OiBwdWJzeXMuYw0KICAgICAgICAkKENDKSAkKENGTEFHUykg
LUkkKElESVIpIC1jIC1vICRAICQ8DQogKi8NCg0KI2luY2x1ZGUgPGxpbnV4
L21vZHVsZS5oPg0KI2luY2x1ZGUgPGxpbnV4L3N0cmluZy5oPg0KI2luY2x1
ZGUgPGxpbnV4L3NsYWIuaD4NCiNpbmNsdWRlIDxsaW51eC9pbml0Lmg+DQoj
aW5jbHVkZSA8bGludXgvc3RhdC5oPg0KI2luY2x1ZGUgPGxpbnV4L2Vyci5o
Pg0KI2luY2x1ZGUgPGxpbnV4L2RyaXZlcmZzX2ZzLmg+DQoNCnN0YXRpYyBM
SVNUX0hFQUQoYmVlcl9saXN0KTsNCnN0YXRpYyBzdHJ1Y3QgZHJpdmVyX2Rp
cl9lbnRyeSAqIHB1Yl9kaXI7DQoNCnN0cnVjdCBiZWVyIHsNCgljaGFyCQkJ
KiBuYW1lOw0KCXN0cnVjdCBsaXN0X2hlYWQJbm9kZTsNCglzdHJ1Y3QgbW9k
dWxlCQkqIG93bmVyOw0KCXN0cnVjdCBkcml2ZXJfZGlyX2VudHJ5ICogZGly
Ow0KfTsNCg0KaW50IGJlZXJfY3JlYXRlX2ZpbGUoc3RydWN0IGJlZXIgKiBi
ZWVyLCBzdHJ1Y3QgZHJpdmVyX2ZpbGVfZW50cnkgKiBlbnRyeSkNCnsNCglp
bnQgZXJyb3IgPSAtRUlOVkFMOw0KCWlmIChiZWVyKQ0KCQllcnJvciA9IGRy
aXZlcmZzX2NyZWF0ZV9maWxlKGVudHJ5LGJlZXItPmRpcik7DQoJcmV0dXJu
IGVycm9yOw0KfQ0KDQp2b2lkIGJlZXJfcmVtb3ZlX2ZpbGUoc3RydWN0IGJl
ZXIgKiBiZWVyLCBzdHJ1Y3QgZHJpdmVyX2ZpbGVfZW50cnkgKiBlbnRyeSkN
CnsNCglpZiAoYmVlcikNCgkJZHJpdmVyZnNfcmVtb3ZlX2ZpbGUoYmVlci0+
ZGlyLGVudHJ5KTsNCn0NCg0Kc3RhdGljIGludCBtYWtlX29uZV9kaXIoY2hh
ciAqIG5hbWUsIA0KCQkJc3RydWN0IGRyaXZlcl9kaXJfZW50cnkgKiogZGly
LCANCgkJCXN0cnVjdCBkcml2ZXJfZGlyX2VudHJ5ICogcGFyZW50LA0KCQkJ
dm9pZCAqIG9iamVjdCkNCnsNCglzdHJ1Y3QgZHJpdmVyX2Rpcl9lbnRyeSAq
IGQ7DQoJaW50IGVycm9yOw0KDQoJZCA9IGttYWxsb2Moc2l6ZW9mKHN0cnVj
dCBkcml2ZXJfZGlyX2VudHJ5KSxHRlBfS0VSTkVMKTsNCglpZiAoIWQpDQoJ
CXJldHVybiAtRU5PTUVNOw0KCW1lbXNldChkLDAsc2l6ZW9mKHN0cnVjdCBk
cml2ZXJfZGlyX2VudHJ5KSk7DQoJZC0+bmFtZSA9IG5hbWU7DQoJZC0+bW9k
ZSA9IChTX0lGRElSfCBTX0lSV1hVIHwgU19JUlVHTyB8IFNfSVhVR08pOw0K
CUlOSVRfTElTVF9IRUFEKCZkLT5maWxlcyk7DQoJZC0+b2JqZWN0ID0gb2Jq
ZWN0Ow0KDQoJaWYgKCEoZXJyb3IgPSBkcml2ZXJmc19jcmVhdGVfZGlyKGQs
cGFyZW50KSkpDQoJCSpkaXIgPSBkOw0KCWVsc2UNCgkJa2ZyZWUoZCk7DQoJ
cmV0dXJuIGVycm9yOw0KfQ0KDQpzdGF0aWMgaW50IGJlZXJfbWFrZV9kaXIo
c3RydWN0IGJlZXIgKiBiZWVyKQ0Kew0KCXJldHVybiBtYWtlX29uZV9kaXIo
YmVlci0+bmFtZSwmYmVlci0+ZGlyLHB1Yl9kaXIsYmVlcik7DQp9DQoNCnN0
YXRpYyB2b2lkIGJlZXJfcmVtb3ZlX2RpcihzdHJ1Y3QgYmVlciAqIGJlZXIp
DQp7DQoJc3RydWN0IGRyaXZlcl9kaXJfZW50cnkgKiBkaXIgPSBiZWVyLT5k
aXI7DQoJYmVlci0+ZGlyID0gTlVMTDsNCglkcml2ZXJmc19yZW1vdmVfZGly
KGRpcik7DQp9DQoNCmludCBiZWVyX3JlZ2lzdGVyKHN0cnVjdCBiZWVyICog
YmVlcikNCnsNCglpbnQgZXJyb3I7DQoJTU9EX0lOQ19VU0VfQ09VTlQ7DQoJ
ZXJyb3IgPSBiZWVyX21ha2VfZGlyKGJlZXIpOw0KCWlmICghZXJyb3IpDQoJ
CWxpc3RfYWRkX3RhaWwoJmJlZXItPm5vZGUsJmJlZXJfbGlzdCk7DQoJZWxz
ZQ0KCQlNT0RfREVDX1VTRV9DT1VOVDsNCglyZXR1cm4gZXJyb3I7DQp9DQoN
CnZvaWQgYmVlcl91bnJlZ2lzdGVyKHN0cnVjdCBiZWVyICogYmVlcikNCnsN
CgliZWVyX3JlbW92ZV9kaXIoYmVlcik7DQoJbGlzdF9kZWwoJmJlZXItPm5v
ZGUpOw0KCU1PRF9ERUNfVVNFX0NPVU5UOw0KfQ0KDQpzdGF0aWMgaW50IF9f
aW5pdCBwdWJfaW5pdCh2b2lkKQ0Kew0KCXJldHVybiBtYWtlX29uZV9kaXIo
InB1YiIsJnB1Yl9kaXIsTlVMTCxOVUxMKTsNCn0NCg0Kc3RhdGljIHZvaWQg
X19leGl0IHB1Yl9leGl0KHZvaWQpDQp7DQoJZHJpdmVyZnNfcmVtb3ZlX2Rp
cihwdWJfZGlyKTsNCn0NCg0KbW9kdWxlX2luaXQocHViX2luaXQpOw0KbW9k
dWxlX2V4aXQocHViX2V4aXQpOw0KDQo=
--346834433-1542255995-1027042097=:2542--
